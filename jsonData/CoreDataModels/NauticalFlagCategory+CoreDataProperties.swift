//
//  NauticalFlagCategory+CoreDataProperties.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/20/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//
//

import Foundation
import CoreData


extension NauticalFlagCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NauticalFlagCategory> {
        return NSFetchRequest<NauticalFlagCategory>(entityName: "NauticalFlagCategory")
    }

    @NSManaged public var category: String?
    @NSManaged public var label: String?
    @NSManaged public var flag: NSSet?

}

// MARK: Generated accessors for flag
extension NauticalFlagCategory {

    @objc(addFlagObject:)
    @NSManaged public func addToFlag(_ value: NauticalFlag)

    @objc(removeFlagObject:)
    @NSManaged public func removeFromFlag(_ value: NauticalFlag)

    @objc(addFlag:)
    @NSManaged public func addToFlag(_ values: NSSet)

    @objc(removeFlag:)
    @NSManaged public func removeFromFlag(_ values: NSSet)

}
