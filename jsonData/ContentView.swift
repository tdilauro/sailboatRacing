//
//  ContentView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/16/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit
import SwiftUI


// Make a SwiftUI view
struct ContentView: View {
    private let jsonURL = "http://127.0.0.1:8000/nautical-flags-with-media.json"
    @Environment(\.managedObjectContext) var moc

//    @ObservedObject var flagsVM: NauticalFlagsViewModel
//    var jsonURL: String

    var body: some View {
        NauticalFlagsListView(flagsVM: NauticalFlagListViewModel(context: moc), jsonURL: jsonURL)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
