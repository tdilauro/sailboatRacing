//
//  NauticalFlagCategories-extension.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/21/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//


import Foundation
import CoreData

extension NauticalFlagCategory {

    class func allCategoryFetchRequest() -> NSFetchRequest<NauticalFlagCategory> {
        let request = NSFetchRequest<NauticalFlagCategory>(entityName: "NauticalFlagCategory")
        request.sortDescriptors = [
            NSSortDescriptor(key: "category", ascending: true)
        ]
        return request
    }

    // MARK: Wrapped Properties

    var wrappedCategory: String {
        category ?? "unnamed"
    }

    var wrappedLabel: String {
        label ?? wrappedCategory
    }

    var flagList: [NauticalFlag] {
        let set = flags as? Set<NauticalFlag> ?? []

        return set.sorted {
            $0.wrappedId < $1.wrappedId
        }
    }

}
