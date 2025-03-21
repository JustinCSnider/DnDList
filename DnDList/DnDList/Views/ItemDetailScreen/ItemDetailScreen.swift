//
//  ItemDetail.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import SwiftUI

struct ItemDetailScreen: View {
    
    let item: SubCategoryItem
    
    @State var results: [String: Any] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(results.keys.sorted(), id: \.self) { key in
                Text(key)
                if let json = results[key] as? [String: Any] {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            ForEach(json.keys.sorted(), id: \.self) { key in
                                Text(key)
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(item.name)
        .task {
            await getItemDetails()
        }
    }
    
    // MARK: - Functions
    
    func getItemDetails() async {
        guard let url = URL(string: "https://www.dnd5eapi.co\(item.url)"),
              let data = await NetworkHelper.performNetworkRequest(for: url),
              let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return
        }
        self.results = jsonData
    }
}
