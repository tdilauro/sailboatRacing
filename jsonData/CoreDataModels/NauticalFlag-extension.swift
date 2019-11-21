//
//  NauticalFlag-extension.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/20/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import Foundation

extension NauticalFlag {

    var wrappedId: String {
        id ?? ""
    }

    var wrappedMnemonic: String {
        mnemonic ?? ""
    }

    var wrappedCategory: NauticalFlagCategory {
        category ?? NauticalFlagCategory()
    }

    var wrappedImage: NauticalFlagImage {
        image ?? NauticalFlagImage()
    }
}
