//
//  Item.swift
//  GTracker
//
//  Created by Govinda Puthalapat on 1/4/25.
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
