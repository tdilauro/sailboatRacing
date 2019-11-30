//
//  NauticalFlag-extension.swift
//
//  Created by Tim DiLauro on 11/20/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData

extension NauticalFlag {

    class func allItemsFetchRequest() -> NSFetchRequest<NauticalFlag> {
        let request = NSFetchRequest<NauticalFlag>(entityName: "NauticalFlag")
        request.sortDescriptors = [
            NSSortDescriptor(key: "category.category", ascending: true),
            NSSortDescriptor(key: "id", ascending: true)
        ]
        return request
    }

    static func allForCategoryFetchRequest(in category: NauticalFlagCategory) -> NSFetchRequest<NauticalFlag> {
        let request = NSFetchRequest<NauticalFlag>(entityName: "NauticalFlag")
        request.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: true)
        ]
        request.predicate = NSPredicate(format: "category == %@", category)
        return request
    }


    // MARK: Wrapped Properties

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
