//
//  SubCateogryList+Data.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

typealias SubCategoryItem = SubCategoryResults.SubCategoryItem

struct SubCategoryResults: Codable {
    let results: [SubCategoryItem]
    
    struct SubCategoryItem: Codable, Hashable {
        let name: String
        let url: String
        let index: String
    }
}
