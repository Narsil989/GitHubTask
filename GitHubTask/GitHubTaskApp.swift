//
//  GitHubTaskApp.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import SwiftUI

@main
struct GitHubTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
