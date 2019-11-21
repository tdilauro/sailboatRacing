//
//  NauticalFlagCategory+CoreDataProperties.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/21/19.
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
    @NSManaged public var flags: NSSet?

}

// MARK: Generated accessors for flags
extension NauticalFlagCategory {

    @objc(addFlagsObject:)
    @NSManaged public func addToFlags(_ value: NauticalFlag)

    @objc(removeFlagsObject:)
    @NSManaged public func removeFromFlags(_ value: NauticalFlag)

    @objc(addFlags:)
    @NSManaged public func addToFlags(_ values: NSSet)

    @objc(removeFlags:)
    @NSManaged public func removeFromFlags(_ values: NSSet)

}
