//
//  NauticalFlagSectionView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/25/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI


struct NauticalFlagSectionView: View {
    @ObservedObject var sectionVM: NauticalFlagSectionViewModel

    @Environment(\.managedObjectContext) var moc

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
        items.forEach( { index in
            let flagVM = self.sectionVM.flags[index]
            print("deleting item \(index): \(flagVM.id)")
            print("deleting object from context")
//            self.sectionVM.flags.remove(at: index)
            moc.delete(flagVM.flag)
            try? moc.save()
            // still need to save
        })
    }
}

//struct NauticalFlagsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NauticalFlagsListView(flagsVM: NauticalFlagsListViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
//    }
//}

