//
//  SubCategoryList.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import SwiftUI

struct SubCategoryListScreen: View {
    
    let category: Category
    
    @State var categoryItems: [SubCategoryItem] = []
    
    var body: some View {
        List(categoryItems, id: \.self) {
            NavigationLink($0.name, value: $0)
        }
        .navigationTitle(category.rawValue)
        .refreshable {
            await reloadData()
        }
        .task {
            await reloadData()
        }
        .navigationDestination(for: SubCategoryItem.self) { item in
            if category == .Classes {
                ClassItemDetailScreen(item: item)
            } else {
                ItemDetailScreen(item: item)
            }
        }
    }
    
    // MARK: - Functions
    
    func reloadData() async {
        guard let url = category.url,
              let data = await NetworkHelper.performNetworkRequest(for: url),
              let results = try? JSONDecoder().decode(SubCategoryResults.self, from: data).results else {
            return
        }
        self.categoryItems = results
    }
}
