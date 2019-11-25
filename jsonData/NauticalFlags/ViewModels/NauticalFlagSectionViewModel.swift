//
//  NauticalFlagSectionViewModel.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/24/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import CoreData
import Combine

class NauticalFlagSectionViewModel {

    let section: NauticalFlagCategory
//    var isExpanded = true

    var flags: [NauticalFlagViewModel] {
        section.flagList.map { NauticalFlagViewModel(item: $0) }
    }

    var category: String {
        section.wrappedCategory
    }

    var label: String {
        section.wrappedLabel
    }

//    private var cancellables = Set<AnyCancellable>()
//    private let context: NSManagedObjectContext
//    @Published private(set) var itemViewModels: [NauticalFlagViewModel] = []

//    private var

//    var itemChanges: AnyPublisher<CollectionDifference<NauticalFlag>, Never> {
//        context.changesPublisher(for: NauticalFlag.allItemsFetchRequest())
//            .catch { _ in Empty() }
//            .map {
//                for change in $0 {
//                    switch change {
//                    case .remove(let offset, let obj, _):
//                        print("remove at offset: \(offset). \(obj.wrappedId) \(obj.category!.category ?? "unknown category")")
//                    case .insert(let offset, let obj, _):
//                        print("insert at offset: \(offset). \(obj.wrappedId) \(obj.category!.category ?? "unknown category")")
//                    }
//                }
//                return $0
//            }
//            .eraseToAnyPublisher()
//    }


    init(_ section: NauticalFlagCategory) {
        self.section = section
    }

//    init(context: NSManagedObjectContext) {
//        self.context = context
//
//        $itemViewModels.applyingChanges(itemChanges) { flag in
//            NauticalFlagViewModel(item: flag)
//        }.assign(to: \.itemViewModels, on: self).store(in: &cancellables)
//    }
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
