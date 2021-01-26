//
//  MyBookshelfApp.swift
//  MyBookshelf
//
//  Created by Destiny Serna on 1/13/21.
//

import SwiftUI

@main
struct MyBookshelfApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
