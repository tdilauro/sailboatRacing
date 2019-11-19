//
//  ContentView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/16/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit
import SwiftUI


typealias FlagCategories = [FlagCategory]

struct FlagCategory: Codable {
    var category: String
    var flags: NauticalFlags
}


typealias NauticalFlags = [NauticalFlag]

class NauticalFlag: ObservableObject, Codable, Identifiable {
    @Published var id: String = ""
    @Published var mnemonic: String = ""
    @Published var media_url: String = ""
    @Published var uiImage = UIImage()

    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        mnemonic = try container.decode(String.self, forKey: .mnemonic)
        media_url = try container.decode(String.self, forKey: .media_url)
        DispatchQueue.global(qos: .userInitiated).async {
            if let img = UIImage(downloadFrom: self.media_url) {
                DispatchQueue.main.async { self.uiImage = img }
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(mnemonic, forKey: .mnemonic)
        try container.encode(media_url, forKey: .media_url)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case mnemonic
        case media_url
    }
}


class NauticalFlagsViewModel: ObservableObject {
    @Published var flagCategories: [FlagCategory] = []

    func loadData(apiURL: String) {
        guard let url = URL(string: apiURL) else {
            print("Invalid URL: '\(apiURL)'")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(FlagCategories.self, from: data)
                DispatchQueue.main.async {
                    self.flagCategories = decodedData
                }
                return
            } catch {
                print(error)
            }

        }.resume()
    }
}


struct NauticalFlagListItem: View {
    @ObservedObject var flag: NauticalFlag

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flag.id)
                    .font(.headline)
                Text(flag.mnemonic)
                    .font(.subheadline)
            }
            Spacer()
            Image(uiImage: flag.uiImage)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }

}


struct NauticalFlagSectionHeader: View {
    var title: String
    var isExpanded: Bool


    var body: some View {
        HStack {
            Text(title)
                .font(.title)
            Image(systemName: isExpanded ? "chevron.up.circle" : "chevron.down.circle")
                .font(.title)
            Spacer()
        }
    }
}

// Make a SwiftUI view
struct ContentView: View {
    private let jsonURL = "http://127.0.0.1:8000/nautical-flags-with-media.json"

    @ObservedObject var flagsVM = NauticalFlagsViewModel()
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
