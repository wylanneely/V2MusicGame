//
//  ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 1/14/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func mainButton(_ sender: Any) {
        
        mainLabel.text = textField.text
        
    }
    
    
    

}

