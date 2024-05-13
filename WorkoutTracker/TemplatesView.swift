//
//  TemplatesView.swift
//  WorkoutTracker

import SwiftUI

struct TemplatesView: View {
    
    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs, SampleWorkouts.push]
    @State private var isEditViewNewWorkoutPresented = false
    @State private var isPresentingEditWorkout: Workout? = nil
    @State private var isPresentingActiveWorkout: Workout? = nil
    
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
                            Button {
                                isEditViewNewWorkoutPresented = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $isEditViewNewWorkoutPresented) {
                                EditTemplateView(workout: nil, editViewNewWorkoutPresented: $isEditViewNewWorkoutPresented)
                            }
                        }
                        .font(.title2)
                        .bold()
                        .padding()
                        
                        ForEach(workouts) { workout in
                            Button {
                                isPresentingActiveWorkout = workout
                            } label: {
                                ZStack {
                                        TemplateView(workout: workout)
                                            .border(Color.black, width: 1)
                                            .cornerRadius(10)
                                            .padding()
                                            .foregroundColor(.black)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                print("Delete workout")
                                            }) {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            .padding(.trailing)
                                            
                                            Button(action: {
                                                print("Edit workout")
                                                isPresentingEditWorkout = workout
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .padding(.trailing)
                                            
//                                            Button(action: {
//                                                // Action to start the workout
//                                            }) {
//                                                Image(systemName: "play.circle.fill")
//                                                    .font(.system(size: 30))
//                                                    .foregroundColor(.green)
//                                            }
                                        }
                                    }
                                }
                            }

                        } // foreach
                        .fullScreenCover(item: $isPresentingEditWorkout) { workout in
                            EditTemplateView(workout: workout, editViewNewWorkoutPresented: $isEditViewNewWorkoutPresented)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .fullScreenCover(item: $isPresentingActiveWorkout) { workout in
                ActiveWorkoutView(workout: workout)
            }
//            .onDisappear {
//
//            }
        }
    }
}

#Preview {
    TemplatesView()
}
