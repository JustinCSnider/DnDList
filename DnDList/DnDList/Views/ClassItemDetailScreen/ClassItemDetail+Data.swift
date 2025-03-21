//
//  ClassItemDetail+Data.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import Foundation

struct ClassItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case subclasses
        case hitDie = "hit_die"
        case startingEquipmentOptions = "starting_equipment_options"
    }
    
    let name: String
    let subclasses: [SubCategoryItem]
    let hitDie: Int
    let startingEquipmentOptions: [StartingEquipmentOption]
    
    struct StartingEquipmentOption: Codable, Hashable {
        let choose: Int
        let type: String
        let desc: String
    }
}
