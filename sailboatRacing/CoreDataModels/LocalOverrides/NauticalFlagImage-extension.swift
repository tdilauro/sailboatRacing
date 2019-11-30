//
//  NauticalFlagImage-extension.swift
//
//  Created by Tim DiLauro on 11/21/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import Foundation


extension NauticalFlagImage {

    var wrappedURL: String {
        url ?? ""
    }

    var wrappedType: String {
        type ?? ""
    }

    var imageData: Data {
        blob ?? Data()
    }
}
