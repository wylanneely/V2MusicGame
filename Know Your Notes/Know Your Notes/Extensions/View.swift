//
//  View.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 10/16/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
