//
//  GamePlayViewController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController, GameSettingsDelegate {
    
 
    
    var settingsController = SettingsController()
    var gameSettings: GameSettings?
    
    
    var selectedNoteButtonIndexes: [Int] = []

    
    //MARK: ViewControllernLifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        creteNavigationAppearence()
        self.gameSettings = settingsController.gameSettings
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: Properties
    
    
    //MARK: Property Functions
    
   
    
  
    
    
    
    //MARK: Navigation
    
    func creteNavigationAppearence() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTextColors") ?? UIColor.systemFill]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTextColors") ?? UIColor.systemFill]
        self.navigationController!.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.destination is SettingsViewController
        {
            let vc = segue.destination as? SettingsViewController
            vc?.delegate = self
            vc?.settingsController = self.settingsController
        }
    }
    
    
    
    //MARK: Delegate
    
    
    @IBAction func toSettings(_ sender: Any) {
        
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    
    
    func updateGameSettings(settings: GameSettings) {
        
        
        self.gameSettings = settings
        self.setButtonNoteStates(selectedNoteIndexes: settings.selectedNotesIndexes
        )
        
        
    }
    
    
    func setButtonNoteStates(selectedNoteIndexes:[Int]){
        
        
        var iteration = 0
        
        
        while iteration <= 11 {
            
            if selectedNoteIndexes.contains(iteration) {
                
                if let button = self.dictionaryForNoteButtons[iteration] {
                DispatchQueue.main.async {
                    button.isHidden = false
                    button.isSelected = true
                }
                    iteration += 1
            }
            } else {
                if let button = self.dictionaryForNoteButtons[iteration] {
                DispatchQueue.main.async {
                    button.isHidden = true
                    button.isSelected = false
                }
                    iteration += 1
            }
    
        }
        }
    }
    
    

    //MARK: Outlets
    
    lazy var dictionaryForNoteButtons:[Int: UIButton] = [0 : aButton,1 : bFButton,2 : bButton,3 : cButton,
        4 : cSButton,
        5 : dButton,6 : eBButton,7 : eButton,9 : fSButton,8 : fButton,10 :  gButton,11 : gSButton]
    
    var noteButtons:[UIButton] { return [aButton,bFButton,bButton,cSButton,
                                         cButton,dButton,eBButton,eButton,
                                         fSButton,fButton,gButton,gSButton] }
    
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

}

