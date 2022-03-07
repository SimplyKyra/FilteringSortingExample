//
//  Item+CoreDataProperties.swift
//  FilteringExample
//
//  Created by Kyra Delaney on 3/7/22.
//
//

import Foundation
import CoreData


extension Item {
    // For filtering
    @objc var wrappedName: String {
        if name == nil {
            return "None"
        } else {
            return name ?? "No Name"
        }
    }
    
    @objc var createdDay: String {
        if created == nil {
            return ""
        } else {
            return created!.formatted(.dateTime.month(.wide).day().year())
        }
    }

    // Because the value is used in the section cache, so if we have the same key path, we get a crash when switching between date sorts.
    @objc var createdDayDescending: String {
        if created == nil {
            return ""
        } else {
            return created!.formatted(.dateTime.month(.wide).day().year()) + " "
        }
    }
    
    @objc var updatedDay: String {
        if lastUpdated == nil {
            return ""
        } else {
            return lastUpdated!.formatted(.dateTime.month(.wide).day().year())
        }
    }

    // Because the value is used in the section cache, so if we have the same key path, we get a crash when switching between date sorts.
    @objc var updatedDayDescending: String {
        if lastUpdated == nil {
            return ""
        } else {
            return lastUpdated!.formatted(.dateTime.month(.wide).day().year()) + " "
        }
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var created: Date?
    @NSManaged public var name: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var details: String?

}

extension Item : Identifiable {

}
