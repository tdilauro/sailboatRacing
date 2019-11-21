//
//  NauticalFlagsListView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI


struct NauticalFlagsListView: View {
    @ObservedObject var flagsVM: NauticalFlagsViewModel
    var jsonURL: String

    @Environment(\.managedObjectContext) var moc
    @Environment(\.managedObjectModel) var moModel
    @FetchRequest(entity: NauticalFlagCategory.entity(), sortDescriptors: []) var categories: FetchedResults<NauticalFlagCategory>

    @State private var sectionState: [Int: Bool] = [:]


    func isExpanded(_ section: Int) -> Bool {
        sectionState[section] ?? true
    }

    func sectionName(_ section: Int) -> String {
        categories[section].wrappedLabel
    }


    var body: some View {
        NavigationView {
            List {
                ForEach(0..<self.categories.count, id: \.self) { section in
                    Section(header:
                        NauticalFlagSectionHeader(title: self.sectionName(section), isExpanded: self.isExpanded(section))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.sectionState[section] = !self.isExpanded(section)
                    }) {
                        if self.isExpanded(section) {
                            ForEach(self.categories[section].flagList.indexed(), id: \.1.wrappedId) { row, flag in
                                NauticalFlagListItem(flag: flag)
                                    .listRowBackground(Color.secondary.opacity(row % 2 == 0 ? 0.8 : 0.5))
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                .navigationBarTitle("Nautical Flags")
                .navigationBarItems(
                    leading: Button(action: {
                        NauticalFlagsImporter().purgeData(managedObjectContext: self.moc,
                                                          managedObjectModel: self.moModel)
                    }, label: { Text("Purge Data") }),
                    trailing: Button(action: {
                        NauticalFlagsImporter().importJSON(from: self.jsonURL, into: self.moc)
                    }, label: { Text("Import Data") }))
        }
    }
}

struct NauticalFlagsListView_Previews: PreviewProvider {
    static var previews: some View {
        NauticalFlagsListView(flagsVM: NauticalFlagsViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
    }
}
