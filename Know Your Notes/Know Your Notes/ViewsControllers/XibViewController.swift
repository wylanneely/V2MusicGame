//
//  XibViewController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 10/16/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit

@IBDesignable
class XibViewController : UIView {

    var contentView:UIView?
    @IBInspectable var nibName:String? = "NoteButtonsStack"
    
    
    override func awakeFromNib() {
         super.awakeFromNib()
         xibSetup()
     }

     func xibSetup() {
         guard let view = loadViewFromNib() else { return }
        
        view.frame = bounds
        view.autoresizingMask =
                    [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
     }

     func loadViewFromNib() -> UIView? {
         guard let nibName = nibName else { return nil }
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(
                     withOwner: self,
                     options: nil).first as? UIView
     }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    
    
}
