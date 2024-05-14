//
//  TemplatesViewModel.swift
//  WorkoutTracker

import FirebaseFirestore
import Foundation


class TemplatesViewModel: ObservableObject {
    @Published var isEditViewNewWorkoutPresented = false
    @Published var isPresentingEditWorkout: Workout? = nil
    @Published var isPresentingActiveWorkout: Workout? = nil
    @Published var workoutTemplates: [Workout] = []
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func fetchWorkoutTemplates() {
        let db = Firestore.firestore()
        db.collection("users/\(userId)/workoutTemplates").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching workout templates: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            // Clear existing workout templates
            self.workoutTemplates.removeAll()
            
            // Append fetched workout templates
            for document in documents {
                do {
                    let workout = try document.data(as: Workout.self)
                    print(workout)
                    self.workoutTemplates.append(workout)
                } catch {
                    print("Error decoding workout: \(error)")
                }
            }
        }
    }
    
    
    
    
    func deleteWorkout(_ workout: Workout) {
        // Remove the workout from Firestore
        print(workout.id)
        Firestore.firestore().collection("users/\(userId)/workoutTemplates").document(workout.id).delete { error in
            if let error = error {
                print("Error deleting workout: \(error)")
            } else {
                print("Workout deleted successfully")
            }
        }
    }
}
