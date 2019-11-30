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

    @Environment(\.managedObjectContext) var moc
    @Environment(\.managedObjectModel) var moModel


    var body: some View {
        NavigationView {
            List {
                ForEach(flagsVM.sections.indexed(), id: \.1.label) { (sequence, sectionVM: NauticalFlagSectionViewModel) in
                    NauticalFlagSectionView(sectionVM: sectionVM)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Nautical Flags")
            .navigationBarItems(
                leading: HStack {
                    if flagsVM.sectionCount > 0 {
                        Button(action: {
                            self.flagsVM.purgeData(managedObjectModel: self.moModel)
                        }, label: { Text("Purge Data") })
                    } else if flagsVM.isImportable {
                        Button(action: {
                            self.flagsVM.importData()
                        }, label: { Text("Import Data") })
                    }
                },
                trailing: EditButton()
            )
        }
    }


    func deleteItem(items: IndexSet) {
        items.forEach({ print("deleting item \($0)") })
    }
}

//struct NauticalFlagsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NauticalFlagsListView(flagsVM: NauticalFlagsListViewModel(), jsonURL: "http://127.0.0.1:8000/nautical-flags-with-media.json")
//    }
//}
