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

    @Published private(set) var sections: [NauticalFlagSectionViewModel] = []

    var sectionCount: Int {
        sections.count
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

    init(context: NSManagedObjectContext) {
        self.context = context

        $sections.applyingChanges(itemChanges) { section in
            NauticalFlagSectionViewModel(section, context: self.context)
        }
        .assign(to: \.sections, on: self)
        .store(in: &cancellables)
    }
}
