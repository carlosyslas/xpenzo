//
//  CategoryColor.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import Foundation
import SwiftUI

enum CategoryColor: String, Codable, CaseIterable {
    case color1
    case color2
    case color3
    case color4
    case color5
    case color6
    
    var foreground: Color {
        switch self {
        case .color1:
                .color1Foreground
        case .color2:
                .color2Foreground
        case .color3:
                .color3Foreground
        case .color4:
                .color4Foreground
        case .color5:
                .color5Foreground
        case .color6:
                .color6Foreground
        }
    }
    
    var background: Color {
        switch self {
        case .color1:
                .color1Background
        case .color2:
                .color2Background
        case .color3:
                .color3Background
        case .color4:
                .color4Background
        case .color5:
                .color5Background
        case .color6:
                .color6Background
        }
    }
}
