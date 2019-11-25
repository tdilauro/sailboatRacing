//
//  NauticalFlagViewModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/22/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import Foundation

class NauticalFlagViewModel {
    let flag: NauticalFlag

    var id: String {
        flag.wrappedId
    }

    var mnemonic: String {
        flag.wrappedMnemonic
    }

    var category: NauticalFlagCategory {
        flag.wrappedCategory
    }

    var image: NauticalFlagImage {
        flag.wrappedImage
    }

    
    init(item: NauticalFlag) {
        self.flag = item
    }
}
