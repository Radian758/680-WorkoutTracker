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
    
    
//    func FetchWorkoutTemplates
    
    func fetchWorkoutTemplates() {
        let db = Firestore.firestore()
        db.collection("users/\(userId)/workoutTemplates").order(by: "date", descending: true).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching workout templates: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            // Clear existing workout templates
            DispatchQueue.main.async {
                self.workoutTemplates = []
                self.workoutTemplates = documents.compactMap { document in
                    do {
                        return try document.data(as: Workout.self)
                    } catch {
                        print("Error decoding workout: \(error)")
                        return nil
                    }
                }
            }
        }
    }

    
    
    
    
    func deleteWorkout(_ workout: Workout) {
        Firestore.firestore().collection("users/\(userId)/workoutTemplates").document(workout.id).delete { error in
            if let error = error {
                print("Error deleting workout: \(error)")
            } else {
                print("Workout deleted successfully")
            }
        }
    }
}
