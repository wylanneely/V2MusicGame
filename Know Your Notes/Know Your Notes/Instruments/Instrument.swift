//
//  Instrument.swift
//  Know Your Notes
//
//  Created by Wylan L Neely on 9/25/19.
//  Copyright © 2019 Wylan L Neely. All rights reserved.
//

import Foundation
import AVFoundation



struct Instrument:Equatable {
    
    
   
    
    static func == (lhs: Instrument, rhs: Instrument) -> Bool {
      return  lhs.name == rhs.name
    }
    
    
    
    
    let name: String
    let notes: [Note]
    
    
    
    
}

let Piano = Instrument(name: "Piano", notes: [])
let Guitar = Instrument(name: "Guitar", notes: [])

