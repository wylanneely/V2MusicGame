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
    
    let gameController = SettingsController()
    var currentGameSessionSettings: GameSettings? = nil
    var hasCompletedOnboarding: Bool = false
    var hasBeatEasy: Bool = false
    var hasBeatRegular: Bool = false
    var hasBeatHard: Bool = false
    var hasUnlockedBanjo: Bool {
        return hasBeatHard
    }

    let UserInitiatedQueue: DispatchQueue = DispatchQueue(label: "UserInitiated", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    //DispatchQoS.QoSClass.userInitiated
    let ActiveUIQueue: DispatchQueue = DispatchQueue(label: "UIActive", qos:.userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    let BackgroundQueue: DispatchQueue = DispatchQueue(label: "Background", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    let SerialQueue: DispatchQueue = DispatchQueue(label: "com.queue.Serial")
    
    
    
    
    let defaults = UserDefaults.standard

    



    mutating func updateGameSettings(with settings: GameSettings) {
        self.currentGameSessionSettings = settings
    }
    
}
//Serial happens One Line At a Time
//let SerialQueue = OS_dispatch_queue_serial.init(label: "SerialQueue)

