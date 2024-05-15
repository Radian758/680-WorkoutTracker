//
//  WorkoutHistoryView.swift
//  WorkoutTracker


import FirebaseFirestoreSwift
import SwiftUI

struct WorkoutHistoryView: View {
    
    @StateObject var viewModel: WorkoutHistoryViewModel
    @FirestoreQuery var workoutHistory: [Workout]
    //    var workoutHistory: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs]
    
    init(userId: String) {
        self._workoutHistory = FirestoreQuery(
            collectionPath: "users/\(userId)/workoutHistory/",
            predicates: [.orderBy("date", true)]
        )
        self._viewModel = StateObject(
            wrappedValue: WorkoutHistoryViewModel(userId: userId)
        )
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
                    
                    Text("Date: \(workout.date, formatter: viewModel.dateFormatter)")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                    
                    ForEach(workout.exercises) { exercise in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.name)
                                .font(.subheadline)
                            
                            ForEach(exercise.sets) { set in
                                HStack {
                                    Text("Reps: \(set.reps)")
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
                .swipeActions {
                    Button("Delete") {
                        print("Deleting workout with ID: \(workout.id)")
                        viewModel.delete(id: workout.id)
                    }
                    .tint(.red)
                }
            }
        }
    }
    
}

#Preview {
    WorkoutHistoryView(userId: "RWU9NGSa9aSEaw257Um3ka3rJk22")
}
