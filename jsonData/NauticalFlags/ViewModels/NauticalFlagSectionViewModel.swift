//
//  NauticalFlagSectionViewModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/24/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData
import Combine

class NauticalFlagSectionViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext

    let section: NauticalFlagCategory
    @Published private(set) var flags: [NauticalFlagViewModel] = []

    var category: String {
        section.wrappedCategory
    }

    var label: String {
        section.wrappedLabel
    }

    var itemChanges: AnyPublisher<CollectionDifference<NauticalFlag>, Never> {
        context.changesPublisher(for: NauticalFlag.allForCategoryFetchRequest(in: section))
            .catch { _ in Empty() }
            .map {
                for change in $0 {
                    switch change {
                    case .remove(let offset, let obj, _):
                        print("remove at offset: \(offset). \(obj.wrappedId) \(obj.wrappedMnemonic)")
                    case .insert(let offset, let obj, _):
                        print("insert at offset: \(offset). \(obj.wrappedId) \(obj.wrappedMnemonic)")
                    }
                }
                return $0
            }
            .eraseToAnyPublisher()
    }

    
    init(_ section: NauticalFlagCategory, context: NSManagedObjectContext) {
        self.section = section
        self.context = context

        $flags.applyingChanges(itemChanges) { flag in
            NauticalFlagViewModel(item: flag)
        }
        .assign(to: \.flags, on: self)
        .store(in: &cancellables)
    }
}



extension NauticalFlagSectionViewModel: Equatable {

    static func == (lhs: NauticalFlagSectionViewModel, rhs: NauticalFlagSectionViewModel) -> Bool {
        lhs.category == rhs.label
    }

}


extension NauticalFlagSectionViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.category)
    }

}
