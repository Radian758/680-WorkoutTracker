//
//  WorkoutTrackerApp.swift
//  WorkoutTracker

import SwiftUI
import FirebaseCore

@main
struct WorkoutTrackerApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
