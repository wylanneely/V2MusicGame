//
//  GamePlayViewController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    var settingsController = SettingsController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.destination is SettingsViewController
        {
            let vc = segue.destination as? SettingsViewController
            vc?.settingsController = self.settingsController
        }

    }

    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }


}
