//
//  ItemSort.swift
//  FilteringExample
//
//  Created by Kyra Delaney on 3/7/22.
//

import Foundation

struct ItemSort: Hashable, Identifiable {
    // identifiable
    let id: Int
    // display name
    let name:String
    // Sort Descriptors
    let descriptors: [SortDescriptor<Item>]
    let section: KeyPath<Item, String>

    static let sorts: [ItemSort] = [
        ItemSort(id: 0,
                 name: "Name | Ascending",
                 descriptors: [
                    SortDescriptor(\Item.name, order: .forward),
                    SortDescriptor(\Item.details, order: .forward)
                 ],
                 section: \Item.wrappedName),
        ItemSort(id: 1,
                 name: "Name | Descending",
                 descriptors: [
                    SortDescriptor(\Item.name, order: .reverse),
                    SortDescriptor(\Item.details, order: .forward)
                 ],
                 section: \Item.wrappedName),
        ItemSort(id: 2,
                 name: "Created Date | Ascending",
                 descriptors: [
                    SortDescriptor(\Item.created, order: .forward),
                    SortDescriptor(\Item.name, order: .forward)
                 ],
                 section: \Item.createdDay),
        ItemSort(id: 3,
                 name: "Created Date | Descending",
                 descriptors: [
                    SortDescriptor(\Item.created, order: .reverse),
                    SortDescriptor(\Item.name, order: .forward)
                 ],
                 section: \Item.createdDayDescending),
        ItemSort(id: 4,
                 name: "Last Updated Date | Ascending",
                 descriptors: [
                    SortDescriptor(\Item.lastUpdated, order: .forward),
                    SortDescriptor(\Item.name, order: .forward)
                 ],
                 section: \Item.updatedDay),
        ItemSort(id: 5,
                 name: "Last Updated Date | Descending",
                 descriptors: [
                    SortDescriptor(\Item.lastUpdated, order: .reverse),
                    SortDescriptor(\Item.name, order: .forward)
                 ],
                 section: \Item.updatedDayDescending),
    ]
    
    static var `default`: ItemSort { sorts[0] }
}
