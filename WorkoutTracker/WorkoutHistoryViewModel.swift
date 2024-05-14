//
//  WorkoutHistoryViewModel.swift
//  WorkoutTracker

import FirebaseFirestore
import Foundation

class WorkoutHistoryViewModel: ObservableObject {
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        Firestore.firestore().collection("users/\(userId)/workoutHistory").document(id).delete { error in
            if let error = error {
                print("Error deleting workout: \(error)")
            } else {
                print("Workout deleted successfully")
            }
        }
    }
    
}
