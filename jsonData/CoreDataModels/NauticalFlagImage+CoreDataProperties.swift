//
//  NauticalFlagImage+CoreDataProperties.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/20/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//
//

import Foundation
import CoreData


extension NauticalFlagImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NauticalFlagImage> {
        return NSFetchRequest<NauticalFlagImage>(entityName: "NauticalFlagImage")
    }

    @NSManaged public var type: String?
    @NSManaged public var blob: Data?
    @NSManaged public var url: String?
    @NSManaged public var flag: NauticalFlag?

}
