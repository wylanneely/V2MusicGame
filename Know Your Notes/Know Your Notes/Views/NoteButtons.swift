//
//  NoteButtons.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 10/16/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class NoteButtonsStack: UIStackView, NibLoadable {

    weak var delegate: NoteButtonsDelegate?
    var selectedNoteButtonIndexes: [Int] = [0,2,3,5,7,8,10]

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Updates
    
    func updateEnabledNotes(_ withIndexes: [Int]){
        setButtonNoteStates(selectedNoteIndexes: withIndexes)
 }
    
    func setButtonNoteStates(selectedNoteIndexes:[Int]){
        var iteration = 0
        while iteration <= 11 {
            if selectedNoteIndexes.contains(iteration) {
                if let button = self.dictionaryForNoteButtons[iteration], let view = self.NoteViewDic[iteration] {
                    DispatchQueue.main.async {
                        button.isHidden = false
                        button.isSelected = true
                        view.isHidden = false
                    }
                    iteration += 1
                }
            } else {
                if let button = self.dictionaryForNoteButtons[iteration], let view = self.NoteViewDic[iteration]  {
                    DispatchQueue.main.async {
                        button.isHidden = true
                        button.isSelected = false
                        view.isHidden = true
                    }
                    iteration += 1
                }
            }
        }
    }
    
    //MARK: Actions

       @IBAction func aTapped(_ sender: Any) {
        delegate?.aButtonTapped()
       }
       @IBAction func bBTapped(_ sender: Any) {
        delegate?.bBButtonTapped()
       }
       @IBAction func bTapped(_ sender: Any) {
        delegate?.bButtonTapped()
       }
       @IBAction func cTapped(_ sender: Any) {
        delegate?.cButtonTapped()
       }
       @IBAction func cSTapped(_ sender: Any) {
        delegate?.cSButtonTapped()
       }
       @IBAction func dTapped(_ sender: Any) {
        delegate?.dButtonTapped()
       }
       @IBAction func eBTapped(_ sender: Any) {
        delegate?.eBButtonTapped()
       }
       @IBAction func eTapped(_ sender: Any) {
        delegate?.eButtonTapped()
       }
       @IBAction func fTapped(_ sender: Any) {
        delegate?.fButtonTapped()
       }
       @IBAction func fSTapped(_ sender: Any) {
        delegate?.fSButtonTapped()
       }
       @IBAction func gTapped(_ sender: Any) {
        delegate?.gButtonTapped()
       }
       @IBAction func gSTapped(_ sender: Any) {
        delegate?.gSButtonTapped()
       }
    
    
    //MARK: Outlets
    //Buttons
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bFButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cSButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eBButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var fSButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var gSButton: UIButton!
    
    lazy var dictionaryForNoteButtons:[Int: UIButton] = [0 : aButton,1 : bFButton,2 : bButton, 3 : cButton,
                                                         4 : cSButton, 5 : dButton,6 : eBButton,7 : eButton,
                                                         9 : fSButton,8 : fButton,10 :  gButton,11 : gSButton]
    
    var noteButtons:[UIButton] { return [aButton,bFButton,bButton,cSButton,
                                         cButton,dButton,eBButton,eButton,
                                         fSButton,fButton,gButton,gSButton] }
    //BackgroundViews
    @IBOutlet weak var AbackgroundView: UIView!
    @IBOutlet weak var bBbackgroundView: UIView!
    @IBOutlet weak var bbackgroundView: UIView!
    @IBOutlet weak var cbackgroundView: UIView!
    @IBOutlet weak var cSbackgroundView: UIView!
    @IBOutlet weak var dbackgroundView: UIView!
    @IBOutlet weak var eBbackgroundView: UIView!
    @IBOutlet weak var ebackgroundView: UIView!
    @IBOutlet weak var fbackgroundView: UIView!
    @IBOutlet weak var fSbackgroundView: UIView!
    @IBOutlet weak var gbackgroundView: UIView!
    @IBOutlet weak var gSbackgroundView: UIView!
    
    lazy var NoteViewDic:[Int:UIView] = [0:AbackgroundView, 1:bBbackgroundView, 2:bbackgroundView, 3:cbackgroundView,
                      4 : cSbackgroundView, 5 : dbackgroundView , 6 : eBbackgroundView, 7 : ebackgroundView,
                      8 : fbackgroundView, 9 : fSbackgroundView, 10 :  gbackgroundView, 11 : gSbackgroundView]

    var noteViews:[UIView] {
        [AbackgroundView, bBbackgroundView, bbackgroundView,cbackgroundView,
     cSbackgroundView, dbackgroundView , eBbackgroundView, ebackgroundView,
     fbackgroundView, fSbackgroundView, gbackgroundView, gSbackgroundView]
    }
    
}

protocol NoteButtonsDelegate: class {
    func aButtonTapped()
    func bBButtonTapped()
    func bButtonTapped()
    func cButtonTapped()
    func cSButtonTapped()
    func dButtonTapped()
    func eBButtonTapped()
    func eButtonTapped()
    func fButtonTapped()
    func fSButtonTapped()
    func gButtonTapped()
    func gSButtonTapped()
}
