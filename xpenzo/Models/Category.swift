//
//  Category.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import Foundation
import SwiftData

import SwiftUI

enum CategoryIcon: String, Codable, CaseIterable {
    case carrot = "carrot"
    case docPlainText = "doc.plaintext"
    case booksVertical = "books.vertical"
    case graduationcap = "graduationcap"
    case paperclip = "paperclip"
    case figureMindAndBody = "figure.mind.and.body"
    case figureSocialDance = "figure.socialdance"
    case figureWeights = "figure.strengthtraining.traditional"
    case heart = "heart"
    case bad = "bag"
    case cart = "cart"
    case creditcard = "creditcard"
    case hammer = "hammer"
    case stethoscope = "stethoscope"
    case suitcaseRolling = "suitcase.rolling"
    case theatermasks = "theatermasks"
    case partyPopper = "party.popper"
    case washer = "washer"
    case iPhone = "iphone.gen1"
    case airplane = "airplane"
    case car = "car"
    case tram = "tram"
    case stroller = "stroller"
    case cat = "cat"
    case teddybear = "teddybear"
    case tshirt = "tshirt"
    case movieclapper = "movieclapper"
    case comb = "comb"
    case paintpalette = "paintpalette"
    case wineglass = "wineglass"
    case forkKnife = "fork.knife"
    case gift = "gift"
    case bitcoinsign = "bitcoinsign"
    case house = "house"
    case gamecontroller = "gamecontroller"
}

@Model
final class Category {
    var name: String
    var color: CategoryColor
    var icon: CategoryIcon
    
    init(name: String, color: CategoryColor, icon: CategoryIcon) {
        self.name = name
        self.color = color
        self.icon = icon
    }
}

struct CategoryKey: Hashable {
    let id: PersistentIdentifier
    let name: String
}
