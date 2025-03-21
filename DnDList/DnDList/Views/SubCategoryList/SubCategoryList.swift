//
//  SubCategoryList.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import SwiftUI

struct SubCategoryList: View {
    
    var category: Category
    
    @State var categoryItems: [SubCategoryItem] = []
    
    var body: some View {
        List(categoryItems, id: \.self) {
            Text($0.name)
        }
        .refreshable {
            await reloadData()
        }
        .navigationTitle(category.rawValue)
        .task {
            await reloadData()
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
