//
//  ContentView.swift
//  WorkoutTracker

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            WorkoutHistoryView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("History", systemImage: "chart.bar.xaxis")
                }
            TemplatesView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Workout",
                          systemImage: "figure.strengthtraining.traditional")
                }
            
        }
    }
    
}

#Preview {
    ContentView()
}
