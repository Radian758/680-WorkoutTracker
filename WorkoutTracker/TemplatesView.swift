//
//  TemplatesView.swift
//  WorkoutTracker

import SwiftUI

struct TemplatesView: View {
    
    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Workout")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                .padding()
                .font(.title2)
                .fontWeight(.bold)
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("My Templates")
                            Spacer()
                            Button(action: {
                                // Navigate to EditTemplateView
                                // "" means it's a brand new workout template
//                                EditTemplateView(workoutID: "")
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                        }
                        .font(.title2)
                        .bold()
                        .padding()
                        
                        ForEach(workouts) { workout in
                            ZStack {
                                NavigationLink(destination: ActiveWorkoutView(workout: workout)) {
                                    TemplateView(workout: workout)
                                        .border(Color.black, width: 1)
                                        .cornerRadius(10)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                                .contentShape(Rectangle())
                                
                                KebabMenu(workout: workout)
                                    .padding(.trailing)
                                    .foregroundColor(.black)
                                    .offset(y: 15)
                            }
                        } // foreach
                    }
                    .padding()
                } // ScrollView
            } // VStack
            .background(Color(UIColor.systemGroupedBackground))
        } // navigationview
    } // body
}

struct KebabMenu: View {
    let workout: Workout
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    Button(action: {
                        // Go to EditTemplateView
//                        EditTemplateView(workoutID: <#T##String#>)
                    }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(action: {
                        // Delete the clicked template
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                }
                .padding(.trailing) // Adjust the padding as needed
                .frame(width: 40, height: 40) // Increase tap area size
            }
            Spacer()
        }
        .padding(.top) // Add padding to move the kebab menu down slightly
    }
}

#Preview {
    TemplatesView()
}
