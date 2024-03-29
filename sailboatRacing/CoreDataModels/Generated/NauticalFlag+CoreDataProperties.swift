//
//  NauticalFlag+CoreDataProperties.swift
//
//  Created by Tim DiLauro on 11/24/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//
//

import Foundation
import CoreData


extension NauticalFlag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NauticalFlag> {
        return NSFetchRequest<NauticalFlag>(entityName: "NauticalFlag")
    }

    @NSManaged public var id: String?
    @NSManaged public var mnemonic: String?
    @NSManaged public var category: NauticalFlagCategory?
    @NSManaged public var image: NauticalFlagImage?

}
