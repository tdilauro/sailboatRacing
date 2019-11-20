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

//    private let jsonURL = "http://127.0.0.1:8000/nautical-flags-with-media.json"
//    @ObservedObject var flagsVM = NauticalFlagsViewModel()
    
    @State private var sectionState: [Int: Bool] = [:]


    func isExpanded(_ section: Int) -> Bool {
        sectionState[section] ?? true
    }

    func sectionName(_ section: Int) -> String {
        flagsVM.flagCategories[section].category
    }


    var body: some View {
        NavigationView {
            List {
                ForEach(0..<self.flagsVM.flagCategories.count, id: \.self) { section in
                    Section(header:
                        NauticalFlagSectionHeader(title: self.sectionName(section), isExpanded: self.isExpanded(section))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.sectionState[section] = !self.isExpanded(section)
                    }) {
                        if self.isExpanded(section) {
                            ForEach((self.flagsVM.flagCategories[section].flags).indexed(), id: \.1.id) { row, flag in
                                NauticalFlagListItem(flag: flag)
                                    .listRowBackground(Color.secondary.opacity(row % 2 == 0 ? 0.8 : 0.5))
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.flagsVM.loadData(apiURL: self.jsonURL)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Nautical Flags")
            .navigationBarItems(trailing: Button(action: {
                self.flagsVM.loadData(apiURL: self.jsonURL)
            }, label: { Text("Load Data") }))
        }
    }
}

struct NauticalFlagsListView_Previews: PreviewProvider {
    static var previews: some View {
        NauticalFlagsListView(flagsVM: NauticalFlagsViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
    }
}
