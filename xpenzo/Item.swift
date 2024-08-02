//
//  Item.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
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
