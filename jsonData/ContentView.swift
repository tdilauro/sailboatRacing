//
//  ContentView.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/16/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

//: A UIKit based Playground for presenting user interface

import UIKit
import SwiftUI


extension String {
    func matches(_ regex: String, options: NSString.CompareOptions = .regularExpression) -> Bool {
        return self.range(of: regex, options: options, range: nil, locale: nil) != nil
    }
}


extension UIImage {

    convenience init?(downloadFrom urlString: String) {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            self.init(data: data)
        } else {
            return nil
        }
    }

}


class FlagCategories: ObservableObject, Codable {
    @Published var names: [String] = []
    @Published var flags: [String: [NauticalFlag]] = [:]

    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flags["Numbers"] = try container.decode([NauticalFlag].self, forKey: .numbers)
        flags["Letters"] = try container.decode([NauticalFlag].self, forKey: .letters)
        names = Array(flags.keys)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(flags["Letters"], forKey: .letters)
        try container.encode(flags["Numbers"], forKey: .numbers)
    }

    enum CodingKeys: String, CodingKey {
        case letters
        case numbers
    }

}

class NauticalFlag: ObservableObject, Codable, Identifiable {
    @Published var id: String = ""
    @Published var mnemonic: String = ""
    @Published var media_url: String = ""
//    var image_name = ""
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
//                .border(Color.black, width: 1)
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
    @State private var flagCategories = FlagCategories()
    @State private var sectionState: [Int: Bool] = [:]

    func isExpanded(_ section: Int) -> Bool {
        sectionState[section] ?? true
    }

    func sectionName(_ section: Int) -> String {
        return flagCategories.names[section]
    }


    var body: some View {
        NavigationView {
            List {
                ForEach(0..<flagCategories.names.count, id: \.self) { section in
                    Section(header:
                        NauticalFlagSectionHeader(title: self.sectionName(section), isExpanded: self.isExpanded(section))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.sectionState[section] = !self.isExpanded(section)
                    }) {
                        if self.isExpanded(section) {
                            ForEach((self.flagCategories.flags[self.sectionName(section)] ?? [NauticalFlag]()).indexed(), id: \.1.id) { row, flag in
                                NauticalFlagListItem(flag: flag)
                                    .listRowBackground(Color.secondary.opacity(row % 2 == 0 ? 0.8 : 0.5))
                            }
                        }
                    }
                }
                .onMove { source, destination in
                    source.forEach { print("move: from \($0) -> \(destination)") }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
            .navigationBarTitle("Nautical Flags")
        .navigationBarItems(trailing: EditButton())
        }
    }

    func loadData() {
        guard let url = URL(string: self.jsonURL) else {
            print("Invalid URL: '\(self.jsonURL)'")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(FlagCategories.self, from: data)
                    DispatchQueue.main.async {
                        self.flagCategories = decodedData
//                        self.flagCategories.flags = decodedData.flags
//                        self.flagCategories.names = decodedData.names
                    }
                    return
                } catch {
                    print(error)
                }
            }

            print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
        }.resume()
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
