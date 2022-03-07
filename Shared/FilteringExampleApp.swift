//
//  FilteringExampleApp.swift
//  Shared
//
//  Created by Kyra Delaney on 3/6/22.
//

import SwiftUI

@main
struct FilteringExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
