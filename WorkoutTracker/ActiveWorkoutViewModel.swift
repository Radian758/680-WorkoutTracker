//
//  ActiveWorkoutViewModel.swift
//  WorkoutTracker

import FirebaseFirestore
import FirebaseAuth
import Foundation

class ActiveWorkoutViewModel: ObservableObject {
    @Published var workoutName: String = ""
    @Published var exercises: [Exercise]// if workout is not nil, assign it workout.exercises
    
    init(workout: Workout) {
        self.workoutName = workout.name
        self.exercises = workout.exercises
    }
    
    func saveWorkoutToHistory(workout: Workout) {
        if let currentUser = Auth.auth().currentUser {
            let userID = currentUser.uid
            let db = Firestore.firestore()
            let workoutHistoryRef = db.collection("users").document(userID).collection("workoutHistory")
            
            let workoutEntry = Workout(
                id: UUID().uuidString,
                name: workoutName,
                date: Date(),
                exercises: exercises
            )
            
            do {
                _ = try workoutHistoryRef.addDocument(from: workoutEntry)
                print("Workout saved to history successfully")
            } catch {
                print("Error saving workout to history: \(error)")
            }
        } else {
            print("No user is currently signed in")
        }
    }
}
