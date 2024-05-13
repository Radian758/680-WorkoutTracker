//
//  TemplatesView.swift
//  WorkoutTracker

import FirebaseFirestoreSwift
import SwiftUI

struct TemplatesView: View {
    
    @FirestoreQuery var workouts: [Workout]
//    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs, SampleWorkouts.push]
    @State private var isEditViewNewWorkoutPresented = false
    @State private var isPresentingEditWorkout: Workout? = nil
    @State private var isPresentingActiveWorkout: Workout? = nil
    
    init(userId: String) {
        //        // users/userID/workoutHistory/
        //
        //        // '_' is the convention for property wrappers
                self._workouts = FirestoreQuery(collectionPath: "users/\(userId)/workouts/")
        //        self._viewModel = StateObject(
        //            wrappedValue: WorkoutHistoryViewModel(userId: userId)
        //        )
    }
    
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
                                .font(.title2)
                                .bold()
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
    TemplatesView(userId: "RWU9NGSa9aSEaw257Um3ka3rJk22")
}
