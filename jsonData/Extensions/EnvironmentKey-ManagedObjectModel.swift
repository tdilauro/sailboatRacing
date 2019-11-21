//
//  EnvironmentKey-ManagedObjectModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/21/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI
import CoreData


struct ManagedObjectModelKey: EnvironmentKey {
    static let defaultValue: NSManagedObjectModel = {
        NSManagedObjectModel()
    }()
}

extension EnvironmentValues {
    var managedObjectModel: NSManagedObjectModel {
        get {
            return self[ManagedObjectModelKey.self]
        }
        set {
            self[ManagedObjectModelKey] = newValue
        }
    }
}
