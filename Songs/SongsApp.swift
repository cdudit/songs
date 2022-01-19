//
//  SongsApp.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

@main
struct SongsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
