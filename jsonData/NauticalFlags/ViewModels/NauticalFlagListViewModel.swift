//
//  NauticalFlagListViewModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData
import Combine

class NauticalFlagListViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext
    private let importURL: String?

    @Published private(set) var sections: [NauticalFlagSectionViewModel] = []

    var sectionCount: Int {
        sections.count
    }

    var isImportable: Bool {
        importURL != nil
    }

    var itemChanges: AnyPublisher<CollectionDifference<NauticalFlagCategory>, Never> {
        context.changesPublisher(for: NauticalFlagCategory.allCategoryFetchRequest())
            .catch { _ in Empty() }
            .map {
                for change in $0 {
                    switch change {
                    case .remove(let offset, let obj, _):
                        print("remove at offset: \(offset). \(obj.wrappedCategory) \(obj.wrappedLabel)")
                    case .insert(let offset, let obj, _):
                        print("insert at offset: \(offset). \(obj.wrappedCategory) \(obj.wrappedLabel)")
                    }
                }
                return $0
            }
            .eraseToAnyPublisher()
    }

    init(context: NSManagedObjectContext, importURL: String? = nil) {
        self.context = context
        self.importURL = importURL

        $sections.applyingChanges(itemChanges) { section in
            NauticalFlagSectionViewModel(section, context: self.context)
        }
        .assign(to: \.sections, on: self)
        .store(in: &cancellables)
    }
}


extension NauticalFlagListViewModel {

    func importData() {
        if let jsonURL = self.importURL {
            NauticalFlagsImporter().importJSON(from: jsonURL, into: self.context)
        }
    }

    func purgeData(managedObjectModel: NSManagedObjectModel) {
        NauticalFlagsImporter().purgeData(managedObjectContext: self.context,
                                      managedObjectModel: managedObjectModel)
    }

}
