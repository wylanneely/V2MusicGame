//
//  GameSetUp.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/25/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation



class GameSettings {
    
     var instrument: Instrument = Instrument(name: "Piano", notes: [])
     var difficulty: Difficulty = .regular
     var selectedNotesIndex: [Int] = []
     var numberOfLifes: Int = 5
     var skipsEnabled: Bool = true
     var numberOfSkips: Int = 10
     var repeatsEnabled: Bool = true
     var numberOfNotes: Int = 7
     
    
    init(intrument: Instrument = Piano, difficulty: Difficulty = .regular, notesIndex: [Int] = [0,1,2,3,4,5,6], lifes:Int = 5, skipOk: Bool = true, skips:Int = 10, repeatsOk: Bool = true, numberOfNotes: Int = 7) {
        self.instrument = intrument
        self.difficulty = difficulty
        self.selectedNotesIndex = notesIndex
        self.instrument = intrument
        self.numberOfLifes = lifes
        self.skipsEnabled = skipOk
        self.numberOfSkips = skips
        self.repeatsEnabled = repeatsOk
        self.numberOfNotes = numberOfNotes
    }
 
}

enum Difficulty: String {
            case easy = "Easy"
            case regular = "Regular"
            case hard = "Hard"
            case custom = "Custom"
}
