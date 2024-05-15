//
//  EditTemplateViewModel.swift
//  WorkoutTracker

import FirebaseAuth
import FirebaseFirestore
import Foundation


class EditTemplateViewModel: ObservableObject {
    @Published  var workoutName: String = ""
    @Published var exercises: [Exercise]
    let workout: Workout?
    
    init(workout: Workout?) {
        self.workout = workout
        self.workoutName = workout?.name ?? ""
        self.exercises = workout?.exercises ?? []
    }
    
    private func deleteWorkout(_ workout: Workout) {
        if let currentUser = Auth.auth().currentUser {
            let userId = currentUser.uid

            Firestore.firestore().collection("users/\(userId)/workoutTemplates").document(workout.id).delete { error in
                if let error = error {
                    print("Error deleting workout: \(error)")
                } else {
                    print("Workout deleted successfully")
                }
            }
        }
    }
    
    func saveWorkout() {
        if let currentUser = Auth.auth().currentUser {
            let userID = currentUser.uid
            
            guard !workoutName.isEmpty else {
                print("Workout name is empty")
                return
            }
            
            let db = Firestore.firestore()
            var workoutData: [String: Any] = [
                "name": workoutName,
                "date": Date(),
                "exercises": exercises.map { $0.asDictionary() }
            ]
            
            if let workout = workout {
                deleteWorkout(workout)
                // Create new workout with the workout ID matching the document ID
                let newWorkoutID = UUID().uuidString
                workoutData["id"] = newWorkoutID
                print("Updating existing workout with ID: \(newWorkoutID)")
                
                db.collection("users")
                    .document(userID)
                    .collection("workoutTemplates")
                    .document(newWorkoutID)
                    .setData(workoutData) { error in
                        if let error = error {
                            print("Error adding workout: \(error)")
                        } else {
                            print("Existing Workout updated successfully")
                        }
                    }
            } else {
                let newWorkoutID = UUID().uuidString
                workoutData["id"] = newWorkoutID
                print("Creating new workout with ID: \(newWorkoutID)")
                
                db.collection("users")
                    .document(userID)
                    .collection("workoutTemplates")
                    .document(newWorkoutID)
                    .setData(workoutData) { error in
                        if let error = error {
                            print("Error adding workout: \(error)")
                        } else {
                            print("New Workout added successfully")
                        }
                    }
            }
        } else {
            print("No user is currently signed in")
        }
    }
    
}
