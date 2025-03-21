//
//  CategoryList+Data.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import Foundation

enum Category: String, CaseIterable {
    case Classes
    case Features
    case Monsters
    case Spells
    
    var url: URL? {
        return switch self {
        case .Classes: URL.init(string: "https://www.dnd5eapi.co/api/2014/classes/")
        case .Features: URL.init(string: "https://www.dnd5eapi.co/api/2014/features/")
        case .Monsters: URL.init(string: "https://www.dnd5eapi.co/api/2014/monsters/")
        case .Spells: URL.init(string: "https://www.dnd5eapi.co/api/2014/spells/")
        }
    }
}
