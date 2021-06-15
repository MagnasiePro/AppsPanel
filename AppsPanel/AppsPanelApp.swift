//
//  AppsPanelApp.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import SwiftUI

@main
struct AppsPanelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
