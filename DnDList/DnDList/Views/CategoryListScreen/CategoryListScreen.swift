//
//  CategoryList.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import SwiftUI

struct CategoryListScreen: View {
    
    var body: some View {
        NavigationStack {
            List(Category.allCases, id: \.self) {
                NavigationLink($0.rawValue, value: $0)
            }
            .navigationDestination(for: Category.self) { category in
                SubCategoryListScreen(category: category)
            }
        }
        
    }
}

#Preview {
    CategoryListScreen()
}
