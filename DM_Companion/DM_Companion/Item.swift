//
//  Item.swift
//  DM_Companion
//
//  Created by Ishaan Bedi on 10/06/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
