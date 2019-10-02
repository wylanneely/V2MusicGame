//
//  GameSessionController.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/30/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation


struct GameController {
    
    let semaphore = DispatchSemaphore(value: 0)
    let globalQueue = DispatchQueue.global()
    let serialQueue = DispatchQueue.init(label: "com.Serial")
    let UIQueue = DispatchQueue.init(label: "com.UI", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency:.never, target: nil)
    let userInitialedQueue = DispatchQueue.init(label: "com.UInitiated", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    func createGame() -> GameSettings {
       return GameSettings()
    }
    
}


