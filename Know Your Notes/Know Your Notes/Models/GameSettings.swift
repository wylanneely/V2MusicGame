//
//  GameSetUp.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/25/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation



struct GameSettings {
    
   //  var instrument: Instrument = Instrument(name: "Piano", notes: [])
     var difficulty: Difficulty = .regular
     var notesAssistant: [NoteAssistant] = []
    
     var numberOfLifes: Int = 5
    var numberOfNotes: Int = 7
     var skipsEnabled: Bool = true
     var numberOfSkips: Int = 10
     var repeatsEnabled: Bool = true
    
 
    init( difficulty: Difficulty = .regular, notesAssist: [NoteAssistant]? = nil, lifes:Int = 5, skipOk: Bool = true, skips:Int = 10, repeatsOk: Bool = true, numberOfNotes: Int = 7) {

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
        self.difficulty = difficulty
        if let notesAssisted = notesAssist  {
            self.notesAssistant = notesAssisted } else {
            self.notesAssistant = [a,bB,b,c,cS,d,eB,e,f,fS,g,gS]
        }
        self.numberOfLifes = lifes
        self.skipsEnabled = skipOk
        self.numberOfSkips = skips
        self.repeatsEnabled = repeatsOk
        self.numberOfNotes = numberOfNotes
    }
    
   mutating func updateLifes(lifesNumber:Int,
    completion: (_ success: Bool) -> Void) {
        self.numberOfLifes = lifesNumber
        completion(true)
    }
    mutating func updateNotes(noteNumber:Int,
    completion: (_ success: Bool) -> Void) {
        self.numberOfNotes = noteNumber
        completion(true)
    }
    mutating func updateSkips(skipsNumber:Int,
    completion: (_ success: Bool) -> Void) {
        self.numberOfSkips = skipsNumber
        completion(true)
    }
    
    func returnNewNoteAssistants(with updatedNoteAssistants: [NoteAssistant])-> [NoteAssistant] {
        var newNoteAssists = refreshedNoteAssistants

        for note in updatedNoteAssistants {
            
            if newNoteAssists.contains(note) {
                newNoteAssists.insert(note, at: note.tag)
                newNoteAssists.remove(at:(note.tag + 1))
            }
        }
        return newNoteAssists
    }
    
   mutating func updateNoteAssistantWith(a:NoteAssistant,
                                 bB:NoteAssistant,
                                 b:NoteAssistant,
                                 c:NoteAssistant,
                                 cS:NoteAssistant,
                                 d:NoteAssistant,
                                 eB:NoteAssistant,
                                 e:NoteAssistant,
                                 f:NoteAssistant,
                                 fS:NoteAssistant,
                                 g:NoteAssistant,
                                 gS:NoteAssistant,
                                 completion: (_ completion: Bool) -> Void) {
        
        self.notesAssistant = [a,bB,c,cS,d,eB,e,f,fS,g,gS]
        completion(true)
    }
    mutating func updateNoteAssistant(notes:[NoteAssistant],
                                 completion: (_ success: Bool) -> Void) {
        self.notesAssistant = notes
        completion(true)
    }
    
    var refreshedNoteAssistants: [NoteAssistant] {
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
        return [a,bB,b,c,cS,d,eB,e,f,fS,g,gS]
    }
    
   mutating func clearNoteAssistants(
   completion: (_ success: Bool) -> Void){
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
        self.notesAssistant = [a,bB,b,c,cS,d,eB,e,f,fS,g,gS]
    
        completion(true)
         }
    
 
}


enum Difficulty: String {
            case easy = "Easy"
            case regular = "Regular"
            case hard = "Hard"
            case custom = "Custom"
}


