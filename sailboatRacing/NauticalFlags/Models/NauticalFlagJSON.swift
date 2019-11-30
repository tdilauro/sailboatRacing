//
//  NauticalFlagJSON.swift
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit
import CoreData

class NauticalFlagsImporter {
    var flagCategories: [FlagCategoryJSON] = []

    func importJSON(from apiURL: String, into moc: NSManagedObjectContext) {
        print("Importing data from \(apiURL)")
        guard let url = URL(string: apiURL) else {
            print("Invalid URL: '\(apiURL)'")
            return
        }

        print("Connecting to \(apiURL)")
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(FlagCategoriesJSON.self, from: data)
                self.flagCategories = decodedData
                self.loadDatabase(managedObjectContext: moc)
            } catch {
                print(error)
            }

        }.resume()
    }

    private func loadDatabase(managedObjectContext moc: NSManagedObjectContext) {
        print("Loading database...", terminator: "")
        for category in flagCategories {
            print(" category: \(category.category) (\(category.flags.count) flags)")
            let cat = NauticalFlagCategory(context: moc)
            cat.label = category.category.capitalized
            cat.category = category.category

            for flag in category.flags {
                print(" flag id: \(flag.id) \(flag.mnemonic)")

                let i = NauticalFlagImage(context: moc)
                i.type = String(flag.media_url.split(separator: ".").last ?? Substring(""))
                i.url = flag.media_url
                i.blob = flag.imageData

                let f = NauticalFlag(context: moc)
                f.id = flag.id
                f.mnemonic = flag.mnemonic
                f.category = cat
                f.image = i

            }
        }
        print("...done")


        if moc.hasChanges {
            print("moc.hasChanges==true, saving...")
            let mergePolicy = moc.mergePolicy
            do {
                moc.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType)
                try moc.save()
                print("moc saved")
            } catch {
                print("Error importing nautical flag JSON data: \(error)")
            }
            moc.mergePolicy = mergePolicy
        } else {
            print("moc.hasChanges==false")

        }

    }

}


typealias FlagCategoriesJSON = [FlagCategoryJSON]
typealias NauticalFlagsJSON = [NauticalFlagJSON]

struct FlagCategoryJSON: Codable {
    var category: String
    var flags: [NauticalFlagJSON]
}


class NauticalFlagJSON: ObservableObject, Codable {
    @Published var id: String = ""
    @Published var mnemonic: String = ""
    @Published var media_url: String = ""
    @Published var imageData = Data()

    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        mnemonic = try container.decode(String.self, forKey: .mnemonic)
        media_url = try container.decode(String.self, forKey: .media_url)
        if let url = URL(string: self.media_url), let data = try? Data(contentsOf: url) {
            self.imageData = data
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

