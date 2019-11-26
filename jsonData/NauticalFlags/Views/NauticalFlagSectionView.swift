//
//  NauticalFlagSectionView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/25/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI


struct NauticalFlagSectionView: View {
    var sectionVM: NauticalFlagSectionViewModel

    @State private var sectionState = true

    var body: some View {
        Section(header:
            NauticalFlagSectionHeader(title: sectionVM.label, isExpanded: self.sectionState)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.sectionState = !self.sectionState
        }) {
            if self.sectionState {
                ForEach(sectionVM.flags.indexed(), id: \.1.id) { row, flagVM in
                    NauticalFlagListItem(flagVM: flagVM)
                        .listRowBackground(Color.secondary.opacity(row % 2 == 0 ? 0.8 : 0.5))
                }
                .onDelete(perform: self.deleteItem)
            }
        }
    }


    func deleteItem(items: IndexSet) {
        items.forEach({ print("deleting item \($0): \(self.sectionVM.flags[$0].id)") })
    }
}

//struct NauticalFlagsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NauticalFlagsListView(flagsVM: NauticalFlagsListViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
//    }
//}

