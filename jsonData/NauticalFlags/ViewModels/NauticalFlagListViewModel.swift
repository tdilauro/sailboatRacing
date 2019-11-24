//
//  NauticalFlagListViewModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData
import Combine

class NauticalFlagListViewModel {
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext
    @Published private(set) var itemViewModels: [NauticalFlagViewModel] = []

//    private var

    var itemChanges: AnyPublisher<CollectionDifference<NauticalFlag>, Never> {
        context.changesPublisher(for: NauticalFlag.allItemsFetchRequest())
            .catch { _ in Empty() }
            .map {
                for change in $0 {
                    switch change {
                    case .remove(let offset, let obj, _):
                        print("remove at offset: \(offset). \(obj.wrappedId) \(obj.category!.category ?? "unknown category")")
                    case .insert(let offset, let obj, _):
                        print("insert at offset: \(offset). \(obj.wrappedId) \(obj.category!.category ?? "unknown category")")
                    }
                }
                return $0
            }
            .eraseToAnyPublisher()
    }

    init(context: NSManagedObjectContext) {
        self.context = context

        $itemViewModels.applyingChanges(itemChanges) { flag in
            NauticalFlagViewModel(item: flag)
        }.assign(to: \.itemViewModels, on: self).store(in: &cancellables)
    }
}
