//
//  NauticalFlagCategories-extension.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/21/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//


import Foundation

extension NauticalFlagCategory {

    var wrappedCategory: String {
        category ?? "unnamed"
    }

    var wrappedLabel: String {
        label ?? wrappedCategory
    }

    var flagList: [NauticalFlag] {
        let set = flag as? Set<NauticalFlag> ?? []

        return set.sorted {
            $0.wrappedId < $1.wrappedId
        }
    }

}
