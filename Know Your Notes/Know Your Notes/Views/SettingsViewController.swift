//
//  SettingsViewController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    
    
    var settingsController: SettingsController!
        
    func updateCurrentSettings() {
//        currentGameSettings.numberOfNotes = self.numberOfNotes
//        currentGameSettings.numberOfSkips = self.numberOfSkips
//        currentGameSettings.numberOfLifes = self.numberOfLifes
//        currentGameSettings.difficulty = self.difficulty
//        currentGameSettings.instrument = self.instrument
    }
    
    var difficulty: Difficulty = .regular
    var numberOfNotes: Int = 4
    var numberOfLifes: Int = 10
    var numberOfSkips: Int = 10
    var noteAssistants: [NoteAssistant] = []
    
    lazy var noteButtons: [UIButton] = [aButton,bFButton,bButton,cSButton,
                                        cButton,dButton,eBButton,eButton,
                                        fSButton,fButton,gSButton,gButton]
    
    
    var selectedNotesIndexesForGameSession: [Int] = []
    
    
    //MARK: View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStepperControllers()
        setUpReg()
    }
    
    func matchViewsToSettings(settings: GameSettings){
        let settings = self.settingsController.gameSettings
        //            self.currentGameSettings = settings
        self.difficulty = settings.difficulty
        self.numberOfLifes = settings.numberOfLifes
        self.numberOfSkips = settings.numberOfSkips
        self.numberOfNotes = settings.numberOfNotes
        self.customSetNotesAssistants(number: settings.numberOfNotes) { (notes) in
            var newSelectedNoteIndexes: [Int] = []
            for note in notes {
                if note.isSelected == true {
                    newSelectedNoteIndexes.append(note.tag)
                }
            }
            self.selectedNotesIndexesForGameSession = newSelectedNoteIndexes
            self.updateNoteButtonsUI(with: notes) { (success) in
                DispatchQueue.main.async {
                    self.lifesLabel.text = "\(settings.numberOfLifes)"
                    self.skipsLabel.text = "\(settings.numberOfSkips)"
                    self.noteAmountLabel.text = "\(settings.numberOfNotes)"
                    self.noteAmountStepper.value = settings.numberOfNotes.double()
                    self.lifesStepper.value = settings.numberOfLifes.double()
                    self.skipsNumberStepper.value = settings.numberOfSkips.double()
                    self.setDifficultyControllerUI(difficulty: settings.difficulty)
                } } }
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        guard let currentGameSettings = gameSessionSettings else { return }
//        updateGameSettingsData(with: currentGameSettings)
    }
    
    //MARK: Settings Object Data
    
    func getNoteAssistance() -> [NoteAssistant] {

        let noteStatesArray = [a,bB,b,c,cS,d,eB,e,f,fS,g,gS]
        
        var newNoteStatesArray: [NoteAssistant] = []
        for selected in selectedNotesIndexesForGameSession {
            for note in noteStatesArray {
                if selected == note.tag {
                    let enabledNote = NoteAssistant(note: note.note, tag: note.tag, isEnabled: true)
                    newNoteStatesArray.append(enabledNote)
                } else {
                    newNoteStatesArray.append(note)
                }
            }
            
        }
        return newNoteStatesArray
    }
    

    var difficultySegmentedControlIndex: Int
    {  switch difficulty
     {  case .easy: return 0
        case .regular: return 1
        case .hard: return 2
        case .custom: return 3 }
    }
//    {
//        didSet { difficultySegmentController.selectedSegmentIndex = self.difficultySegmentedControlIndex }
//     }
    

    //MARK: View Functions
    
    func setupStepperControllers()
      {  skipsNumberStepper.maximumValue = 30
         lifesStepper.maximumValue = 21
         lifesStepper.minimumValue = 1
         skipsNumberStepper.minimumValue = 1
         noteAmountStepper.maximumValue = 12
         noteAmountStepper.minimumValue = 2  }
    
    func updateGameSettings(completion: (_ success: Bool) -> Void)
      {
        let newSettings = GameSettings(difficulty: self.difficulty, notesAssist: self.noteAssistants, lifes: self.numberOfLifes, skipOk: true, skips: self.numberOfSkips, repeatsOk: true, numberOfNotes: self.numberOfNotes)
        
        self.settingsController.gameSettings = newSettings
        completion(true)
     }

    func setUpEasy() {
        
        customSetNotesAssistants(number: 4) { (notes) in
          self.updateNoteButtonsUI(with: notes) { (success) in
              
              self.numberOfLifes = 10
              self.numberOfSkips = 10
              self.numberOfNotes = 4
              self.difficulty = .easy
              DispatchQueue.main.async {
              self.lifesLabel.text = "10"
              self.skipsLabel.text = "10"
              self.noteAmountLabel.text = "4"
              self.noteAmountStepper.value = 4.00
              self.lifesStepper.value = 10.00
              self.skipsNumberStepper.value = 10.00
              self.difficultySegmentController.selectedSegmentIndex = 0
              }
          }
  
        }
        
        
    }
    
    func setUpReg()
      {
        let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
        let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
        let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
        let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
        let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
        let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
        let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
        
        let notes = [0,2,3,5,7,8,10]
        self.selectedNotesIndexesForGameSession = notes
        
        let newNoteAssistant = self.settingsController.gameSettings.returnNewNoteAssistants(with: [aNote,bNote,cNote,dNote,eNote,fNote,gNote])
        
        self.noteAssistants = newNoteAssistant

        self.updateNoteButtonsUI(with: newNoteAssistant) { (success) in
            self.numberOfLifes = 7
            self.numberOfSkips = 7
            self.numberOfNotes = 7
            self.difficulty = .regular
            DispatchQueue.main.async {
                self.lifesStepper.value = 7.00
                self.skipsNumberStepper.value = 7.00
                self.noteAmountStepper.value = 7.00
                self.lifesLabel.text = "7"
                self.skipsLabel.text = "7"
                self.noteAmountLabel.text = "7"
                self.difficultySegmentController.selectedSegmentIndex = 1
            }
        }
    }
    
    func setUpHard()
    {
        let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
        let bBNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
        let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
        let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
        let cSNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
        let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
        let eBNote = NoteAssistant(note: "eB", tag: 6, isEnabled: true)
        let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
        let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
        let fSNote = NoteAssistant(note: "fS", tag: 9, isEnabled: true)
        let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
        let gSNote = NoteAssistant(note: "gS", tag: 11, isEnabled: true)
        
        let notes = [0,1,2,3,4,5,6,7,8,9,10,11]
        self.selectedNotesIndexesForGameSession = notes
        let newNoteAssistant = [aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote]
        self.noteAssistants = newNoteAssistant

        self.updateNoteButtonsUI(with: newNoteAssistant) { (success) in
            self.numberOfLifes = 3
            self.numberOfSkips = 5
            self.numberOfNotes = 12
            self.difficulty = .hard
            DispatchQueue.main.async {
                self.lifesLabel.text = "3"
                self.noteAmountLabel.text = "12"
                self.skipsLabel.text = "5"
                self.noteAmountStepper.value = 12.00
                self.lifesStepper.value = 3.00
                self.skipsNumberStepper.value = 5.00
                self.difficultySegmentController.selectedSegmentIndex = 2
            }
        }
     }
    
    //MARK:Custom Setup
    func customSetUpWithLifes(number numberOfLifes:Int)
    {
        self.difficultySegmentController.selectedSegmentIndex = 3

            self.numberOfLifes = numberOfLifes
            self.difficulty = .custom
            DispatchQueue.main.async {
                self.lifesStepper.value = Double(numberOfLifes)
                self.lifesLabel.text = "\(numberOfLifes)"
        }
    }
    
    func customSetUpWithSkips(number NumberOfSkips:Int)
    {
        self.difficultySegmentController.selectedSegmentIndex = 3
            self.numberOfSkips = NumberOfSkips
            self.difficulty = .custom
            DispatchQueue.main.async {
                self.skipsNumberStepper.value = Double(NumberOfSkips)
                self.skipsLabel.text = "\(NumberOfSkips)"
        }
    }
    
    func customSetUpWithNotes(number: Int)
    {
        self.customSetNotesAssistants(number: number) { (notes) in
            var newSelectedNoteIndexes: [Int] = []
            self.noteAssistants = notes

            for note in notes {
                if note.isSelected == true {
                    newSelectedNoteIndexes.append(note.tag)
                }
            }
          
            self.selectedNotesIndexesForGameSession = newSelectedNoteIndexes
            
            self.updateNoteButtonsUI(with: notes) { (success) in
                self.numberOfNotes = number
                self.difficulty = .custom
                DispatchQueue.main.async {
                    self.noteAmountStepper.value = Double(number)
                    self.noteAmountLabel.text = "\(number)"
                    self.numberOfNotes = number
                } } }
    }
    
    func customSetNotesAssistants(number: Int, completion: (_ completion: [NoteAssistant]) -> Void)  {
                let aNote = NoteAssistant.init(note: "a", tag: 0)
                let bBNote = NoteAssistant.init(note: "bB", tag: 1)
                let bNote = NoteAssistant.init(note: "b", tag: 2)
                let cNote = NoteAssistant.init(note: "c", tag: 3)
                let cSNote = NoteAssistant.init(note: "cS", tag: 4)
                let dNote = NoteAssistant.init(note: "d", tag: 5)
                let eBNote = NoteAssistant.init(note: "eB", tag: 6)
                let eNote = NoteAssistant.init(note: "e", tag: 7)
                let fNote = NoteAssistant.init(note: "f", tag: 8)
                let fSNote = NoteAssistant.init(note: "fS", tag: 9)
                let gNote = NoteAssistant.init(note: "g", tag: 10)
                let gSNote = NoteAssistant.init(note: "gS", tag: 11)
        switch number {
        case 2:
            aNote.enable()
            bNote.enable()
            let notes = [0,2]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 3:
            aNote.enable()
            bNote.enable()
            cNote.enable()
            let notes = [0,2,3]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 4:
            aNote.enable()
            bNote.enable()
            cNote.enable()
            dNote.enable()
            let notes = [0,2,3,5]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 5:
            aNote.enable()
            bNote.enable()
            cNote.enable()
            dNote.enable()
            eNote.enable()
            let notes = [0,2,3,5,7]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 6:
            aNote.enable()
            bNote.enable()
            cNote.enable()
            dNote.enable()
            eNote.enable()
            fNote.enable()
            let notes = [0,2,3,5,7,8]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 7:
            aNote.enable()
            bNote.enable()
            cNote.enable()
            dNote.enable()
            eNote.enable()
            fNote.enable()
            gNote.enable()
            let notes = [0,2,3,5,7,8,10]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 8:
            aNote.enable()
            bBNote.enable()
            bNote.enable()
            cNote.enable()
            dNote.enable()
            eNote.enable()
            fNote.enable()
            gNote.enable()
            let notes = [0,1,2,3,5,7,8,10]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 9:
            aNote.enable()
            bBNote.enable()
            bNote.enable()
            cNote.enable()
            cSNote.enable()
            dNote.enable()
            eNote.enable()
            fNote.enable()
            gNote.enable()
            let notes = [0,1,2,3,4,5,7,8,10]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 10:
            aNote.enable()
            bBNote.enable()
            bNote.enable()
            cNote.enable()
            cSNote.enable()
            dNote.enable()
            eBNote.enable()
            eNote.enable()
            fNote.enable()
            gNote.enable()
            let notes = [0,1,2,3,4,5,6,7,8,10]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 11:
            aNote.enable()
            bBNote.enable()
            bNote.enable()
            cNote.enable()
            cSNote.enable()
            dNote.enable()
            eBNote.enable()
            eNote.enable()
            fNote.enable()
            fSNote.enable()
            gNote.enable()
            let notes = [0,1,2,3,4,5,6,7,8,9,10]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        case 12:
            aNote.enable()
            bBNote.enable()
            bNote.enable()
            cNote.enable()
            cSNote.enable()
            dNote.enable()
            eBNote.enable()
            eNote.enable()
            fNote.enable()
            fSNote.enable()
            gNote.enable()
            gSNote.enable()
            let notes = [0,1,2,3,4,5,6,7,8,11]
            self.selectedNotesIndexesForGameSession = notes
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        default:
            completion([aNote,bBNote,bNote,cNote,cSNote,dNote,eBNote,eNote,fNote,fSNote,gNote,gSNote])
        }
}
//               var buttonTag = 0
//
//        if number <= 7 {
//            while buttonTag <= 11 {
//                switch buttonTag {
//                case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                newNoteAssistants.append(aNote)
//                    buttonTag += 1
//                case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                    newNoteAssistants.append(bNote)
//                        buttonTag += 1
//                case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                    newNoteAssistants.append(cNote)
//                        buttonTag += 1
//                case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                    newNoteAssistants.append(dNote)
//                        buttonTag += 1
//                case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                    newNoteAssistants.append(eNote)
//                        buttonTag += 1
//                case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                    newNoteAssistants.append(fNote)
//                        buttonTag += 1
//                case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                    newNoteAssistants.append(gNote)
//                        buttonTag += 1
//                default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                    newNoteAssistants.append(disabledNote)
//                        buttonTag += 1
//                }
//            }
//        } else if number == 8 {
//                while buttonTag <= 11 {
//                    switch buttonTag {
//                    case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                    newNoteAssistants.append(aNote)
//                        buttonTag += 1
//                    case 1: let bNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                        newNoteAssistants.append(dNote)
//                            buttonTag += 1
//                    case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                        newNoteAssistants.append(eNote)
//                            buttonTag += 1
//                    case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                        newNoteAssistants.append(gNote)
//                            buttonTag += 1
//                    default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                        newNoteAssistants.append(disabledNote)
//                            buttonTag += 1
//                    }
//            }
//        } else if number == 9 {
//                while buttonTag <= 11 {
//                    switch buttonTag {
//                    case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                    newNoteAssistants.append(aNote)
//                        buttonTag += 1
//                    case 1: let bNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 4: let cNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                        newNoteAssistants.append(dNote)
//                            buttonTag += 1
//                    case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                        newNoteAssistants.append(eNote)
//                            buttonTag += 1
//                    case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                        newNoteAssistants.append(gNote)
//                            buttonTag += 1
//                    default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                        newNoteAssistants.append(disabledNote)
//                            buttonTag += 1
//                    }
//            }
//        } else if number == 10 {
//                while buttonTag <= 11 {
//                    switch buttonTag {
//                    case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                    newNoteAssistants.append(aNote)
//                        buttonTag += 1
//                    case 1: let bNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 4: let cNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                        newNoteAssistants.append(dNote)
//                            buttonTag += 1
//                    case 6: let cNote = NoteAssistant(note: "eB", tag: 6, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                        newNoteAssistants.append(eNote)
//                            buttonTag += 1
//                    case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                        newNoteAssistants.append(gNote)
//                            buttonTag += 1
//                    default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                        newNoteAssistants.append(disabledNote)
//                            buttonTag += 1
//                    }
//            }
//        } else if number == 11 {
//                while buttonTag <= 11 {
//                    switch buttonTag {
//                    case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                    newNoteAssistants.append(aNote)
//                        buttonTag += 1
//                    case 1: let bNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 4: let cNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                        newNoteAssistants.append(dNote)
//                            buttonTag += 1
//                    case 6: let cNote = NoteAssistant(note: "eB", tag: 6, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                        newNoteAssistants.append(eNote)
//                            buttonTag += 1
//                    case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 9: let fNote = NoteAssistant(note: "fS", tag: 9, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                        newNoteAssistants.append(gNote)
//                            buttonTag += 1
//                    default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                        newNoteAssistants.append(disabledNote)
//                            buttonTag += 1
//                    }
//            }
//        } else if number == 12 {
//                while buttonTag <= 11 {
//                    switch buttonTag {
//                    case 0: let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
//                    newNoteAssistants.append(aNote)
//                        buttonTag += 1
//                    case 1: let bNote = NoteAssistant(note: "bB", tag: 1, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 2: let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
//                        newNoteAssistants.append(bNote)
//                            buttonTag += 1
//                    case 3: let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 4: let cNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 5: let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
//                        newNoteAssistants.append(dNote)
//                            buttonTag += 1
//                    case 6: let cNote = NoteAssistant(note: "eB", tag: 6, isEnabled: true)
//                        newNoteAssistants.append(cNote)
//                            buttonTag += 1
//                    case 7: let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
//                        newNoteAssistants.append(eNote)
//                            buttonTag += 1
//                    case 8: let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 9: let fNote = NoteAssistant(note: "fS", tag: 9, isEnabled: true)
//                        newNoteAssistants.append(fNote)
//                            buttonTag += 1
//                    case 10: let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
//                        newNoteAssistants.append(gNote)
//                            buttonTag += 1
//                    case 11: let gNote = NoteAssistant(note: "gS", tag: 11, isEnabled: true)
//                    newNoteAssistants.append(gNote)
//                        buttonTag += 1
//                    default: let disabledNote = NoteAssistant(note: "none", tag: buttonTag, isEnabled: false)
//                        newNoteAssistants.append(disabledNote)
//                            buttonTag += 1
//                    }
//            }
//        }
    
    func customDefaultSetUp()
    {
        let aNote = NoteAssistant(note: "a", tag: 0, isEnabled: true)
        let bNote = NoteAssistant(note: "b", tag: 2, isEnabled: true)
        let cNote = NoteAssistant(note: "c", tag: 3, isEnabled: true)
        let cSNote = NoteAssistant(note: "cS", tag: 4, isEnabled: true)
        let dNote = NoteAssistant(note: "d", tag: 5, isEnabled: true)
        let eNote = NoteAssistant(note: "e", tag: 7, isEnabled: true)
        let fNote = NoteAssistant(note: "f", tag: 8, isEnabled: true)
        let gNote = NoteAssistant(note: "g", tag: 10, isEnabled: true)
        
        let notes = [0,2,3,4,5,7,8,10]
        self.selectedNotesIndexesForGameSession = notes
        
        let newNoteAssistant = self.settingsController.gameSettings.returnNewNoteAssistants(with: [aNote,bNote,cNote,cSNote,dNote,eNote,fNote,gNote])
        self.noteAssistants = newNoteAssistant

        self.updateNoteButtonsUI(with: newNoteAssistant) { (success) in
            self.numberOfLifes = 5
            self.numberOfSkips = 10
            self.numberOfNotes = 8
            self.difficulty = .custom
            DispatchQueue.main.async {
                self.lifesStepper.value = 5.00
                self.skipsNumberStepper.value = 10.00
                self.noteAmountStepper.value = 8.00
                self.lifesLabel.text = "5"
                self.skipsLabel.text = "10"
                self.noteAmountLabel.text = "8"
                self.difficultySegmentController.selectedSegmentIndex = 3
            }
        }
    }
    
    //MARK: DataHandleing
    
    func changeSelectedNotes(buttonTag:Int) {
        
 
        if let lastSelectedNoteIndex = selectedNotesIndexesForGameSession.last {
            let oldButton = buttonTagDictionary[lastSelectedNoteIndex]
            let newButton = buttonTagDictionary[buttonTag]
            selectedNotesIndexesForGameSession.append(buttonTag)
            selectedNotesIndexesForGameSession.removeLast()
            DispatchQueue.main.async {
                oldButton?.isEnabled = false
                newButton?.isEnabled = true
            }
            
        }
  
    }

    //MARK: UIHandleing
    
    func updateNoteButtonsUI(with noteAssistants: [NoteAssistant], completion: (_ success: Bool) -> Void){
        
        for button in self.noteButtons {
            for note in noteAssistants {
                if note.tag == button.tag   {
                    button.isSelected = note.isSelected
            }
                
            }
        }
        completion(true)
    }
        
    func updateSettingsUI() {
            self.lifesStepper.value = Double(self.numberOfLifes)
            self.skipsNumberStepper.value = Double( self.numberOfSkips)
            self.noteAmountStepper.value = Double( self.numberOfNotes)
            
            DispatchQueue.main.async {
                self.lifesLabel.text = self.numberOfLifes.description
                self.skipsLabel.text =  self.numberOfSkips.description
                self.noteAmountLabel.text =  self.numberOfNotes.description
            }
        }
    
    
    func changeButtonStatesTo(notesNumber: Int) {
        if difficultySegmentController.selectedSegmentIndex < 3 {
            self.customSetUpWithNotes(number: notesNumber)
            self.difficultySegmentController.selectedSegmentIndex = 3
        } else {
            self.customSetUpWithNotes(number: notesNumber)
        }
    }
    
    func updateButtonStatesUsingSelectedNoteIndexes(){
            for button in noteButtons {
                if selectedNotesIndexesForGameSession.contains(button.tag) {
                    DispatchQueue.main.async {
                        button.isSelected = true
                    }
                } else {
                    DispatchQueue.main.async {
                        button.isSelected = false
                    }
                }
            }
        
        
        
        
        
    }
    
    func updateSelectedButtonsIndexes(newButtonTag:Int,completion: (_ competion: Bool) -> Void) {
        if selectedNotesIndexesForGameSession.isEmpty == false {
                selectedNotesIndexesForGameSession.removeLast()
                selectedNotesIndexesForGameSession.insert(newButtonTag, at: 0)
                completion ( true )
             } else {
                completion ( false )
            }
         }
    
    //NewGameSettingsHandeler
    
    var createNotesIndexForNewGameSession: [Int] {
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
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.difficulty = .easy
                self.setUpEasy()
            
        case 1:
            self.difficulty = .regular
                self.setUpReg()
            
        case 2:
            self.difficulty = .hard
                self.setUpHard()
            
        case 3:
            self.difficulty = .custom
            self.customDefaultSetUp()
        default:
            break
        }
    }
        //MARK: Stepper Changed Functions
    @IBAction func noteStepperAmountChanged(_ sender: UIStepper) {
        let newNotesValue = Int(sender.value)
        noteAmountLabel.text = "\(newNotesValue)"
        customSetUpWithNotes(number: newNotesValue)
    }

    @IBAction func skipsNumberChanged(_ sender: UIStepper) {
        let skipsNumber = Int(sender.value)
        customSetUpWithSkips(number: skipsNumber)
    }
    
    @IBAction func lifesNumberChanged(_ sender: UIStepper) {
        let lifesNumber = Int(sender.value)
        customSetUpWithLifes(number: lifesNumber)
    }
    
      //MARK: Note Buttons Functions

    @IBAction func aTapped(_ sender: Any) {
        if aButton.isSelected == true {
            aButton.isSelected = true
            return
        } else {
                self.updateSelectedButtonsIndexes(newButtonTag: 0) { (success) in
                    if success == true {
                    self.updateButtonStatesUsingSelectedNoteIndexes()
                    }
            }
        }
    }
    @IBAction func bFTapped(_ sender: Any) {
           if  bFButton.isSelected == true {
               bFButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 1) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    @IBAction func bTapped(_ sender: Any) {
      if    bButton.isSelected == true {
            bButton.isSelected = true
            
            return
        } else {
                self.updateSelectedButtonsIndexes(newButtonTag: 2) { (success) in
                    if success == true {
                    self.updateButtonStatesUsingSelectedNoteIndexes()
                    }
            }
        }
    }
    @IBAction func cTapped(_ sender: Any) {
        if     cButton.isSelected == true {
            cButton.isSelected = true
            return
        } else {
                self.updateSelectedButtonsIndexes(newButtonTag: 3) { (success) in
                    if success == true {
                    self.updateButtonStatesUsingSelectedNoteIndexes()
                    }
            }
        }
    }
    @IBAction func cSTapped(_ sender: Any) {
        if     cSButton.isSelected == true {
               cSButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 4) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
  
    @IBAction func dTapped(_ sender: Any) {
        if     dButton.isSelected == true {
               dButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 5) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    @IBAction func eBTapped(_ sender: Any) {
        if     eBButton.isSelected == true {
               eBButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 6) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    @IBAction func eTapped(_ sender: Any) {
        if     eButton.isSelected == true {
               eButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 7) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    @IBAction func fTapped(_ sender: Any) {
        if     fButton.isSelected == true {
               fButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 8) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    @IBAction func fSTapped(_ sender: Any) {
        if     fSButton.isSelected == true {
            fSButton.isSelected = true
            return
        } else {
                self.updateSelectedButtonsIndexes(newButtonTag: 9) { (success) in
                    if success == true {
                    self.updateButtonStatesUsingSelectedNoteIndexes()
                    }
            }
        }
    }
    @IBAction func gTapped(_ sender: Any) {
        if     gButton.isSelected == true {
               gButton.isSelected = true
               return
           } else {
                   self.updateSelectedButtonsIndexes(newButtonTag: 10) { (success) in
                       if success == true {
                       self.updateButtonStatesUsingSelectedNoteIndexes()
                       }
               }
           }
    }
    
    @IBAction func gSTapped(_ sender: Any) {
        if     gSButton.isSelected == true {
            gSButton.isSelected = true
            return
        } else {
                self.updateSelectedButtonsIndexes(newButtonTag: 11) { (success) in
                    if success == true {
                    self.updateButtonStatesUsingSelectedNoteIndexes()
                    }
            }
        }
    }
    @IBAction func doneButonSelected(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Outlets
        //MARK: d
    @IBOutlet weak var difficultySegmentController: UISegmentedControl!
    
    func setDifficultyControllerUI(difficulty: Difficulty ){
        switch difficulty {
        case .easy: self.difficultySegmentController.selectedSegmentIndex = 0
        case .regular: self.difficultySegmentController.selectedSegmentIndex = 1
        case .hard: self.difficultySegmentController.selectedSegmentIndex = 2
        case .custom: self.difficultySegmentController.selectedSegmentIndex = 3
        }
    }
    
    @IBOutlet weak var instrumentSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var noteAmountLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    @IBOutlet weak var skipsLabel: UILabel!
    
    @IBOutlet weak var noteAmountStepper: UIStepper!
    @IBOutlet weak var lifesStepper: UIStepper!
    @IBOutlet weak var skipsNumberStepper: UIStepper!
    
    lazy var buttonTagDictionary: [Int:UIButton] = [0:aButton,1:bFButton,2:bButton,3:cButton,
                                                    4:cSButton,5:dButton,6:eBButton,7:eButton,
                                                    8:fSButton,9:fButton,10:gSButton,11:gButton]
    
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

    let a = NoteAssistant.init(note: "a", tag: 0)
    let bB = NoteAssistant.init(note: "bB", tag: 1)
    let b = NoteAssistant.init(note: "b", tag: 2)
    let c = NoteAssistant.init(note: "c", tag: 3)
    let cS = NoteAssistant.init(note: "cS", tag: 4)
    let d = NoteAssistant.init(note: "d", tag: 5)
    let eB = NoteAssistant.init(note: "eB", tag: 6)
    let e = NoteAssistant.init(note: "e", tag: 7)
    let f = NoteAssistant.init(note: "f", tag: 8)
    let fS = NoteAssistant.init(note: "fS", tag: 9)
    let g = NoteAssistant.init(note: "g", tag: 10)
    let gS = NoteAssistant.init(note: "gS", tag: 11)
    

}
