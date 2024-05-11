//
//  WorkoutHistoryView.swift
//  WorkoutTracker

import FirebaseFirestoreSwift
import SwiftUI

struct WorkoutHistoryView: View {
    
//    @StateObject var viewModel: WorkoutHistoryViewModel
//    @FirestoreQuery var workouts: [Workout]
//
    init(userId: String) {
//        // users/<id>/workouts/<entries>
//
//        // '_' is the convention for property wrappers
//        self._workouts = FirestoreQuery(collectionPath: "users/\(userId)/workouts/")
//        self._viewModel = StateObject(
//            wrappedValue: WorkoutHistoryViewModel(userId: userId)
//        )
    }
    
    var body: some View {
        Text("WorkoutHistoryView")
//        List(workouts) { workout in
//            VStack(alignment: .leading) {
//                Text(workout.name)
//                    .font(.headline)
//                Text("Date: \(workout.date, formatter: DateFormatter())")
//                    .font(.subheadline)
//                ForEach(workout.exercises, id: \.name) { exercise in
//                    VStack(alignment: .leading) {
//                        Text(exercise.name)
//                            .font(.subheadline)
//                        // Display sets for the exercise
//                        ForEach(exercise.sets, id: \.self) { set in
//                            Text("Reps: \(set.reps), Weight: \(set.weight)")
//                                .font(.caption)
//                        }
//                    }
//                }
//            }
//        }
    }
    
}

#Preview {
    WorkoutHistoryView(userId: "")
}
