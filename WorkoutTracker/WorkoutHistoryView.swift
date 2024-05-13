//
//  WorkoutHistoryView.swift
//  WorkoutTracker


import FirebaseFirestoreSwift
import SwiftUI

struct WorkoutHistoryView: View {
    
    //    @StateObject var viewModel: WorkoutHistoryViewModel
        @FirestoreQuery var workoutHistory: [Workout]
//    var workoutHistory: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs]
    
    init(userId: String) {
        //        // users/userID/workoutHistory/
        //
        //        // '_' is the convention for property wrappers
                self._workoutHistory = FirestoreQuery(collectionPath: "users/\(userId)/workoutHistory/")
        //        self._viewModel = StateObject(
        //            wrappedValue: WorkoutHistoryViewModel(userId: userId)
        //        )
        print("WorkoutHistoryView Initialized!")
    }
    
    var body: some View {
        List {
            Text("WorkoutHistoryView")
            ForEach(workoutHistory) { workout in
                VStack(alignment: .leading, spacing: 8) {
                    Text(workout.name)
                        .font(.headline)
                        .padding(.bottom, 4)
                        .padding(.horizontal)
                        .background(Color.secondary)
                        .foregroundColor(.white)
                    
                    Text("Date: \(workout.date, formatter: DateFormatter())")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                    
                    ForEach(workout.exercises) { exercise in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.name)
                                .font(.subheadline)
                            
                            ForEach(exercise.sets) { set in
                                HStack {
                                    Text("Reps: \(String(format: "%.1f", set.reps))")
                                        .font(.caption)
                                    Text("Weight: \(String(format: "%.1f", set.weight)) lbs")
                                        .font(.caption)
                                }
                                .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
    }
    
}

#Preview {
    WorkoutHistoryView(userId: "RWU9NGSa9aSEaw257Um3ka3rJk22")
}
