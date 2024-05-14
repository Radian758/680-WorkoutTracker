//
//  WorkoutHistoryViewModel.swift
//  WorkoutTracker

import FirebaseFirestore
import Foundation

class WorkoutHistoryViewModel: ObservableObject {
    private let userId: String
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
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
