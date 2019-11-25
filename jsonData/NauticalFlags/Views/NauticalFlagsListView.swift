//
//  NauticalFlagsListView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI


struct NauticalFlagsListView: View {
    @ObservedObject var flagsVM: NauticalFlagListViewModel
    var jsonURL: String

    @Environment(\.managedObjectContext) var moc
    @Environment(\.managedObjectModel) var moModel

    @State private var sectionState: [Int: Bool] = [:]

    func isExpanded(_ section: Int) -> Bool {
        sectionState[section] ?? true
    }


    var body: some View {
        NavigationView {
            List {
                ForEach(flagsVM.sections.indexed(), id: \.1.label) { (sequence, sectionVM: NauticalFlagSectionViewModel) in
                    Section(header:
                        NauticalFlagSectionHeader(title: sectionVM.label, isExpanded: self.isExpanded(sequence))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.sectionState[sequence] = !self.isExpanded(sequence)
                    }) {
                        if self.isExpanded(sequence) {
                            ForEach(sectionVM.flags.indexed(), id: \.1.id) { row, flagVM in
                                NauticalFlagListItem(flagVM: flagVM)
                                    .listRowBackground(Color.secondary.opacity(row % 2 == 0 ? 0.8 : 0.5))
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Nautical Flags")
            .navigationBarItems(
                leading: HStack {
                    if flagsVM.sectionCount > 0 {
                        Button(action: {
                            NauticalFlagsImporter().purgeData(managedObjectContext: self.moc,
                                                              managedObjectModel: self.moModel)
                        }, label: { Text("Purge Data") })
                    } else {
                        Button(action: {
                            NauticalFlagsImporter().importJSON(from: self.jsonURL, into: self.moc)
                        }, label: { Text("Import Data") })
                    }

                }
            )
        }
    }
}

//struct NauticalFlagsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NauticalFlagsListView(flagsVM: NauticalFlagsListViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
//    }
//}
