//
//  ClassItemDetailScreen.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import SwiftUI

struct ClassItemDetailScreen: View {
    
    let item: SubCategoryItem
    
    @State var loading: Bool = false
    @State var classItem: ClassItem?
    @State var hasAppeared: Bool = false // would normally have this as a view modifier but for now it's hear as a state variable
    
    @ViewBuilder func subclassesView() -> some View {
        if let classItem {
            Text("Subclasses: \(classItem.subclasses.isEmpty ? "None" : "")")
                .bold()
            ForEach(classItem.subclasses, id: \.self) { subclass in
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(subclass.name)
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder func startingEquipmentOptionsView() -> some View {
        if let classItem {
            Text("Starting Equipment Options: \(classItem.startingEquipmentOptions.isEmpty ? "None" : "")")
                .bold()
            VStack(spacing: 16) {
                ForEach(classItem.startingEquipmentOptions, id: \.self) { option in
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("Type:")
                                    .fontWeight(.medium)
                                Text("\(option.type)")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Text("Description:")
                                    .fontWeight(.medium)
                                Text("\(option.desc)")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Text("Choose:")
                                    .fontWeight(.medium)
                                Text("\(option.choose)")
                                Spacer()
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let classItem {
                    Card(title: "Hit Die", subView: Text("\(classItem.hitDie)"))
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .frame(height: 64)
                    subclassesView()
                        .padding(.top, 24)
                    HStack {
                        Text("Hit die:")
                            .bold()
                        Text("\(classItem.hitDie)")
                        Spacer()
                    }
                    startingEquipmentOptionsView()
                } else if self.loading {
                    Text("Loading...")
                } else {
                    Text("No data found...")
                }
            }
        }
        .navigationTitle(item.name)
        .onAppear {
            Task {
                if hasAppeared == false {
                    self.loading = true
                    await getItemDetails()
                    self.loading = false
                    self.hasAppeared = true
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func getItemDetails() async {
        guard let url = URL(string: "https://www.dnd5eapi.co\(item.url)"),
              let data = await NetworkHelper.performNetworkRequest(for: url),
              let classItem = try? JSONDecoder().decode(ClassItem.self, from: data) else {
            return
        }
        self.classItem = classItem
    }
}


struct Card<SubView: View>: View {
    
    let title: String
    @ViewBuilder let subView: SubView
    
    init(title: String, subView: SubView) {
        self.title = title
        self.subView = subView
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.white)
                .shadow(radius: 4)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title)
                        .bold()
                    Spacer()
                }
                subView
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}
