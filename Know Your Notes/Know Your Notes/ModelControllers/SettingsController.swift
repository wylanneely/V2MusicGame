//
//  GameSessionController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation


class SettingsController {
    
    var gameSettings: GameSettings
    
    init(){
        self.gameSettings = GameSettings()
    }

}



public class NoteAssistant: Comparable {
    
    let note: String
    let tag: Int
    var isSelected: Bool = false
    
    func disable() {
        isSelected = false
    }
    
    func enable() {
        isSelected = true
    }
    
    init(note:String, tag: Int, isEnabled enabled: Bool = false) {
        self.note = note
        self.tag = tag
        self.isSelected = enabled
    }
    
    public static func < (lhs: NoteAssistant, rhs: NoteAssistant) -> Bool {
      return  lhs.tag < rhs.tag
    }
    
    public static func == (lhs: NoteAssistant, rhs: NoteAssistant) -> Bool {
        return  lhs.tag == rhs.tag
    }
}


