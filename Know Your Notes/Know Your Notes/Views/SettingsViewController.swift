//
//  SettingsViewController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setStepperValues()
        if let currentSettings = currentSettings {
            setCurrentGameSettings(settings: currentSettings) }
        else { setUpReg()
            return }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let currentGameSettings = currentSettings else { return }
        setCurrentGameSettings(settings: currentGameSettings)
    }
    
    
    //MARK: Settings Object Data
    
    let gameController = GameController()
    
    var currentSettings: GameSettings? = nil
    
    var numberOfNotes: Int = 7
    var numberOfLifes: Int = 5
    var numberOfSkips: Int = 5
    var selectedNotesIndex: [Int] = []
    
    var difficulty: Difficulty = .easy {
        didSet { difficultySegmentController.selectedSegmentIndex = self.difficultySegmentedControlIndex
        }
     }
    
    var difficultySegmentedControlIndex: Int
     {  switch difficulty
      {  case .easy: return 0
         case .regular: return 1
         case .hard: return 2
         case .custom: return 3 }
     }
    
    var noteButtons: [UIButton]
      { return [aButton,bFButton,bButton,cSButton,cButton,dButton,
                eBButton,eButton,fSButton,fButton,gSButton,gButton] }

    //MARK: SettingsViewSetup
    func setStepperValues()
      {  skipsNumberStepper.maximumValue = 30
         lifesStepper.maximumValue = 21
         lifesStepper.minimumValue = 1
         skipsNumberStepper.minimumValue = 1
         noteAmountStepper.maximumValue = 12
         noteAmountStepper.minimumValue = 2  }
    
    func setCurrentGameSettings(settings: GameSettings)
      {  self.difficulty = settings.difficulty
         self.currentSettings = settings
        
       switch settings.difficulty {
        case .easy :
         self.currentSettings = settings
         self.numberOfLifes = settings.numberOfLifes
         self.numberOfNotes = settings.numberOfNotes
         self.numberOfSkips = settings.numberOfSkips
         self.selectedNotesIndex = settings.selectedNotesIndex
              updateSettingsUI()
        case .regular :
         self.currentSettings = settings
         self.numberOfLifes = settings.numberOfLifes
         self.numberOfNotes = settings.numberOfNotes
         self.numberOfSkips = settings.numberOfSkips
         self.selectedNotesIndex = settings.selectedNotesIndex
              updateSettingsUI()
        case .hard :
         self.currentSettings = settings
         self.numberOfLifes = settings.numberOfLifes
         self.numberOfNotes = settings.numberOfNotes
         self.numberOfSkips = settings.numberOfSkips
         self.selectedNotesIndex = settings.selectedNotesIndex
              updateSettingsUI()
        case .custom :
         self.currentSettings = settings
         self.numberOfLifes = settings.numberOfLifes
         self.numberOfNotes = settings.numberOfNotes
         self.numberOfSkips = settings.numberOfSkips
         self.selectedNotesIndex = settings.selectedNotesIndex
              updateSettingsUI() }
     }
    func setUpEasy()
    { gameController.serialQueue.sync {
        self.deselectButtonStates()
         let notes = [0,3,5,10]
         self.selectedNotesIndex = notes
        self.updateStatesforNoteButtons(selectedNotesIndex: notes)
    
        DispatchQueue.main.async {
             self.lifesLabel.text = "10"
             self.lifesStepper.value = 10.00
              self.numberOfLifes = 10
              self.numberOfSkips = 10
              self.skipsNumberStepper.value = 10.00
              self.skipsLabel.text = "10"
            self.difficultySegmentController.selectedSegmentIndex = 0
        
        }
        }

    }
    func setUpReg()
      { gameController.serialQueue.sync {
         let notes = [0,2,3,5,7,8,10]
         self.selectedNotesIndex = notes
        self.deselectButtonStates()
         self.updateStatesforNoteButtons(selectedNotesIndex: notes)
        
        DispatchQueue.main.async {
         self.lifesLabel.text = "7"
         self.lifesStepper.value = 7.00
         self.numberOfLifes = 7
         self.numberOfSkips = 7
         self.skipsNumberStepper.value = 7.00
         self.skipsLabel.text = "7"
            self.difficultySegmentController.selectedSegmentIndex = 1

        }
        
        }
    }
    
    func setUpHard()
        
    {
        gameController.serialQueue.sync {
        let notes = [0,1,2,3,4,5,6,7,8,9,10,11]
        self.selectedNotesIndex = notes
            self.deselectButtonStates()

        self.updateStatesforNoteButtons(selectedNotesIndex: notes)
        DispatchQueue.main.async {
            
         self.lifesLabel.text = "3"
         self.lifesStepper.value = 3.00
         self.numberOfLifes = 3
         self.numberOfSkips = 5
         self.skipsNumberStepper.value = 5.00
         self.skipsLabel.text = "5"
        self.difficultySegmentController.selectedSegmentIndex = 2

        }
    }
     }
    
    func customDefaultSetUp()
    {
        gameController.serialQueue.sync {
        self.deselectButtonStates()
    let notes = [1,4,6,9,11]
     self.selectedNotesIndex = notes
     self.updateStatesforNoteButtons(selectedNotesIndex: notes)
     DispatchQueue.main.async
     {   self.lifesLabel.text = "3"
         self.lifesStepper.value = 3.00
         self.numberOfLifes = 3
         self.numberOfSkips = 5
         self.skipsNumberStepper.value = 5.00
         self.skipsLabel.text = "5"
         self.difficultySegmentController.selectedSegmentIndex = 3

        }
            self.gameController.semaphore.signal()

        }
     }
    
    //MARK: DataHandleing
    
    func updateSelectedNotesIndex(buttonTag:Int) {
        selectedNotesIndex.removeLast()
        selectedNotesIndex.insert(buttonTag, at: 0)
    }
    
    func upsateSettingData() {
        guard let settings = currentSettings else {return}
        self.numberOfLifes = settings.numberOfLifes
        self.numberOfNotes = settings.numberOfNotes
        self.numberOfSkips = settings.numberOfSkips
        self.selectedNotesIndex = settings.selectedNotesIndex
    }
    
    //MARK: UIHandleing
    
    func updateSettingsUI() {
        
            self.deselectButtonStates()
            self.updateStatesforNoteButtons(selectedNotesIndex: self.selectedNotesIndex)
        
            self.lifesStepper.value = Double(self.numberOfLifes)
            self.lifesLabel.text = self.numberOfLifes.description
        self.skipsNumberStepper.value = Double( self.numberOfSkips)
        self.skipsLabel.text =  self.numberOfSkips.description
        self.noteAmountStepper.value = Double( self.numberOfNotes)
        self.noteAmountLabel.text =  self.numberOfNotes.description
        
        
            
        
    }
    
    func deselectButtonStates(){
        gameController.UIQueue.async {
        var index = 0
        while index <= 11  {
            switch index {
            case 0:
                self.aButton.isSelected = false
            case 1:
                self.bFButton.isSelected = false
            case 2:
                self.bButton.isSelected = false
            case 3:
                self.cButton.isSelected = false
            case 4:
                self.cSButton.isSelected = false
            case 5:
                self.dButton.isSelected = false
            case 6:
               self.eBButton.isSelected = false
            case 7:
               self.eButton.isSelected = false
            case 8:
               self.fButton.isSelected = false
            case 9:
               self.fSButton.isSelected = false
            case 10:
               self.gButton.isSelected = false
            case 11:
                self.gSButton.isSelected = false
            default:
                break
            }
            index += 1
        }
        }
        
    }
    
    func updateStatesforNoteButtons(selectedNotesIndex:[Int]){
        DispatchQueue.main.async {

        for index in selectedNotesIndex {
            switch index {
            case 0:
                self.aButton.isSelected = true
            case 1:
                self.bFButton.isSelected = true
            case 2:
                self.bButton.isSelected = true
            case 3:
                self.cButton.isSelected = true
            case 4:
                self.cSButton.isSelected = true
            case 5:
                self.dButton.isSelected = true
            case 6:
                self.eBButton.isSelected = true
            case 7:
                self.eButton.isSelected = true
            case 8:
                self.fButton.isSelected = true
            case 9:
                self.fSButton.isSelected = true
            case 10:
                self.gButton.isSelected = true
            case 11:
                self.gSButton.isSelected = true
            default:
                break
            }
        }
         
        }
    }
    
    
    func changeButtonStatesTo(notesNumberTag: Int) {
        gameController.UIQueue.async {
            
            self.difficulty = .custom
        var noteButtonTag = 0
        while noteButtonTag <= notesNumberTag {
            for button in self.noteButtons {
                if button.tag == noteButtonTag {
                    button.isSelected = true
                }
            }
            noteButtonTag += 1
        }
            var deselectNotesTag = notesNumberTag
        while deselectNotesTag <= 11 {
            for button in self.noteButtons {
                if button.tag == deselectNotesTag {
                    button.isSelected = false
                }
                deselectNotesTag += 1  }
            }
        }
        
    }
    
    func deselectLastButton(){
        gameController.UIQueue.async {
            
    guard let lastSelectedNoteTag = self.selectedNotesIndex.last else {return}
           
        switch lastSelectedNoteTag {
        case 0:
            self.aButton.isSelected = false
        case 1:
            self.bFButton.isSelected = false
        case 2:
            self.bButton.isSelected = false
        case 3:
            self.cButton.isSelected = false
        case 4:
            self.cSButton.isSelected = false
        case 5:
            self.dButton.isSelected = false
        case 6:
            self.eBButton.isSelected = false
        case 7:
            self.eButton.isSelected = false
        case 8:
            self.fButton.isSelected = false
        case 9:
            self.fSButton.isSelected = false
        case 10:
            self.gButton.isSelected = false
        case 11:
            self.gSButton.isSelected = false
        default:
            return
        }
        }
    }
    
    //NewGameSettingsHandeler
    
    var createNotesIndexForNewGameSession:[Int] {
        var nNotesUsedIndex:[Int] = []
        if aButton.isSelected == true {
            nNotesUsedIndex.append(0)
        }
        if bFButton.isSelected == true {
            nNotesUsedIndex.append(1)
        }
        if bButton.isSelected == true {
            nNotesUsedIndex.append(2)
        }
        if cButton.isSelected == true {
            nNotesUsedIndex.append(3)
        }
        if cSButton.isSelected == true {
            nNotesUsedIndex.append(4)
        }
        if dButton.isSelected == true {
            nNotesUsedIndex.append(5)
        }
        if eBButton.isSelected == true {
            nNotesUsedIndex.append(6)
        }
        if eButton.isSelected == true {
            nNotesUsedIndex.append(7)
        }
        if fButton.isSelected == true {
            nNotesUsedIndex.append(8)
        }
        if fSButton.isSelected == true {
            nNotesUsedIndex.append(9)
        }
        if gSButton.isSelected == true {
            nNotesUsedIndex.append(10)
        }
        if gButton.isSelected == true {
            nNotesUsedIndex.append(11)
        }
        return nNotesUsedIndex
    }
    
    //MARK: IBActions
        //MARK: Segment Control Function
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        case 0:
            self.difficulty = .easy
                self.deselectButtonStates()
                self.setUpEasy()
            
        case 1:
            self.difficulty = .regular
                self.deselectButtonStates()
                self.setUpReg()
            
        case 2:
            self.difficulty = .hard
                self.deselectButtonStates()
                self.setUpHard()
            
        case 3:
            self.difficulty = .custom
                self.deselectButtonStates()
                self.setUpHard()
            
        default:
            break
    }
        //MARK: Stepper Changed Functions
    @IBAction func notesAmountChanges(_ sender: UIStepper) {
        deselectButtonStates()
        let newNotesValue = Int(sender.value)
        noteAmountLabel.text = "\(newNotesValue)"
        numberOfNotes = newNotesValue
        changeButtonStatesTo(notesNumberTag: Int(sender.value))
        difficultySegmentController.selectedSegmentIndex = 3
    }

    @IBAction func skipsNumberChanged(_ sender: UIStepper) {
        let skipsNumber = Int(sender.value)
        skipsLabel.text = "\(skipsNumber)"
        self.numberOfSkips = skipsNumber
        difficultySegmentController.selectedSegmentIndex = 3
    }
    
    @IBAction func lifesNumberChanged(_ sender: UIStepper) {
        let lifesNumber = Int(sender.value)
        lifesLabel.text = "\(lifesNumber)"
        self.numberOfLifes = lifesNumber
        difficultySegmentController.selectedSegmentIndex = 3
    }
    
      //MARK: Note Buttons Functions

    @IBAction func aTapped(_ sender: Any) {
        if aButton.isSelected == true {
            aButton.isSelected = true
            return
        } else {
            aButton.isSelected = true
            deselectLastButton()
            updateSelectedNotesIndex(buttonTag: 0)
            return
        }
    }
    @IBAction func bFTapped(_ sender: Any) {
           if  bFButton.isSelected == true {
               bFButton.isSelected = true
               return
           } else {
               bFButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 1)
               return
           }
    }
    @IBAction func bTapped(_ sender: Any) {
      if    bButton.isSelected == true {
            bButton.isSelected = true
            return
        } else {
            bButton.isSelected = true
            deselectLastButton()
            updateSelectedNotesIndex(buttonTag: 2)
            return
        }
    }
    @IBAction func cSTapped(_ sender: Any) {
        if     cSButton.isSelected == true {
               cSButton.isSelected = true
               return
           } else {
               cSButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 3)
               return
           }
    }
    @IBAction func cTapped(_ sender: Any) {
        if     cButton.isSelected == true {
               cButton.isSelected = true
               return
           } else {
               cButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 4)
               return
           }
    }
    @IBAction func dTapped(_ sender: Any) {
        if     dButton.isSelected == true {
               dButton.isSelected = true
               return
           } else {
               dButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 5)
               return
           }
    }
    @IBAction func eBTapped(_ sender: Any) {
        if     eBButton.isSelected == true {
               eBButton.isSelected = true
               return
           } else {
               eBButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 6)
               return
           }
    }
    @IBAction func eTapped(_ sender: Any) {
        if     eButton.isSelected == true {
               eButton.isSelected = true
               return
           } else {
               eButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 7)
               return
           }
    }
    @IBAction func fSTapped(_ sender: Any) {
        if     fSButton.isSelected == true {
               fSButton.isSelected = true
               return
           } else {
               fSButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 8)
               return
           }
    }
    @IBAction func fTapped(_ sender: Any) {
        if     fButton.isSelected == true {
               fButton.isSelected = true
               return
           } else {
               fButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 9)
               return
           }
    }
    @IBAction func gSTapped(_ sender: Any) {
        if     gSButton.isSelected == true {
               gSButton.isSelected = true
               return
           } else {
               gSButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 10)
               return
           }
    }
    @IBAction func gTapped(_ sender: Any) {
        if     gButton.isSelected == true {
               gButton.isSelected = true
               return
           } else {
               gButton.isSelected = true
               deselectLastButton()
               updateSelectedNotesIndex(buttonTag: 11)
               return
           }
    }
    
    @IBAction func doneButonSelected(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    //Outlets
    
    @IBOutlet weak var difficultySegmentController: UISegmentedControl!
    @IBOutlet weak var instrumentSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var noteAmountLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    @IBOutlet weak var skipsLabel: UILabel!
    
    @IBOutlet weak var noteAmountStepper: UIStepper!
    @IBOutlet weak var lifesStepper: UIStepper!
    @IBOutlet weak var skipsNumberStepper: UIStepper!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bFButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cSButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eBButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fSButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gSButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    
}
