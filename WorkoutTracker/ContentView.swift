//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Adrian Vasquez on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            accountView
        } else {
            LoginView()
        }
//        VStack {
//            Text("ContentView")
//        }
//        .padding()
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
            TemplatesView()
                .tabItem {
                    Label("Profile",
                          systemImage: "figure.strengthtraining.traditional")
                }
            
        }
    }
    
}

#Preview {
    ContentView()
}
