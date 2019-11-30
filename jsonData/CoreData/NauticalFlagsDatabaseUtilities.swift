//
//  NauticalFlagsDatabaseUtilities.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/29/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData

class NauticalFlagsDatabaseUtilities {

    func purgeData(managedObjectContext moc: NSManagedObjectContext,
                   managedObjectModel model: NSManagedObjectModel) {
        let entityNames = model.entities.compactMap({ $0 }).map({ $0.name! })
        entityNames.forEach { entityName in
            print("Purging CoreData entity '\(entityName)'")
            resetAllRecords(in: entityName, managedObjectContext: moc)
        }
    }

    private func resetAllRecords(in entityName : String, managedObjectContext moc: NSManagedObjectContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        deleteRequest.resultType = .resultTypeObjectIDs
        do {
            let result = try moc.execute(deleteRequest) as! NSBatchDeleteResult
            print("Merge changes, if possible")
            if let deletedObjectIds = result.result as? [NSManagedObjectID] {
                print("Merging changes (\(deletedObjectIds.count))", terminator: "...")
                let changes: [AnyHashable : Any] = [NSDeletedObjectsKey : deletedObjectIds]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes , into: [moc])
                print("...done")
            }
        } catch {
            print ("Error purging data for entity '\(entityName)': \(error.localizedDescription)")
        }
    }
}
