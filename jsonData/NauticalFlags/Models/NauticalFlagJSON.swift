//
//  NauticalFlagJSON.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit


typealias FlagCategories = [FlagCategory]
typealias NauticalFlags = [NauticalFlag]

struct FlagCategory: Codable {
    var category: String
    var flags: [NauticalFlag]
}


class NauticalFlag: ObservableObject, Codable {
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

