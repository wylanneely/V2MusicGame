//
//  GlobalGameHandler.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 10/1/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation


var GlobalAppHandler = AppHandler()


struct AppHandler {
    let gameController = GameController()
    let defaults = UserDefaults.standard
    
    var hasCompletedOnboarding: Bool = false
    var hasBeatEasy: Bool = false
    var hasBeatRegular: Bool = false
    var hasBeatHard: Bool = false
    var hasUnlockedBanjo: Bool {
        return hasBeatHard
    }
    

    var currentGameSettings = GameSettings(intrument: Piano)
    

    mutating func updateGameSettings(with settings: GameSettings) {
        self.currentGameSettings = settings
    }
    
    
    
    

    
    
    
    
}
