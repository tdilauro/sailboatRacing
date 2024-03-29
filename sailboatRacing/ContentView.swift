//
//  ContentView.swift
//
//  Created by Tim DiLauro on 11/16/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit
import SwiftUI


// Make a SwiftUI view
struct ContentView: View {
    private let jsonURL = "https://api.jsonbin.io/b/5ddf52f73da40e6f299136a5"
//    private let jsonURL = "http://127.0.0.1:8000/nautical-flags-with-media.json"
//    private let jsonURL = "http://127.0.0.1:8000/nautical-flags-images-hosted-lensdump.json"
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NauticalFlagsListView(flagsVM: NauticalFlagListViewModel(context: moc, importURL: jsonURL))
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
