//
//  EditTemplateView.swift
//  WorkoutTracker

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EditTemplateView: View {
    @State var workoutName: String = ""
    @State var exercises: [Exercise]// if workout is not nil, assign it workout.exercises
    let workout: Workout? // if workout is nil, create empty workout template
    @Binding var isEditViewNewWorkoutPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(workout: Workout?, editViewNewWorkoutPresented: Binding<Bool>) {
        self.workout = workout
        self._isEditViewNewWorkoutPresented = editViewNewWorkoutPresented
        
        if let workout = workout {
            self._workoutName = State(initialValue: workout.name)
            print("workout is not nil!")
        } else {
            print("workout is nil: \(workout)")
        }
        self._exercises = State(initialValue: workout?.exercises ?? [])
        print("EditTemplateView initialized")
    }
    
    var body: some View {
        Text("Edit Template")
        HStack() {
            Spacer()
            Button(action: {
                // Save the workout template
                saveWorkout()
                print("Exited EditTemplateView")
                isEditViewNewWorkoutPresented = false
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Finish")
            })
        }
        .padding()
        
        ScrollView {
            VStack {
                TextField("Workout Template Name", text: $workoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Add Exercise button
                Button(action: {
                    exercises.append(Exercise(name: "", sets: []))
                }) {
                    Text("Add Exercise")
                }
                
                // Display existing exercises
                ForEach(exercises.indices, id: \.self) { index in
                    ExerciseView(exercise: $exercises[index])
                }
            }
            .padding()
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        
        if let currentUser = Auth.auth().currentUser {
            let userId = currentUser.uid
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
                // Convert exercises to Firestore-compatible data
                "exercises": exercises.map { $0.asDictionary() }
            ]
            
            if let workout = workout {
                deleteWorkout(workout)
                // Create new workout with the workout ID matching the document ID
                let newWorkoutID = UUID().uuidString
                workoutData["id"] = newWorkoutID
                print("Creating new workout with ID: \(newWorkoutID)")
                
                db.collection("users")
                    .document(userID)
                    .collection("workoutTemplates")
                    .document(newWorkoutID) // Use the same ID for the document
                    .setData(workoutData) { error in
                        if let error = error {
                            print("Error adding workout: \(error)")
                        } else {
                            print("New Workout added successfully")
                        }
                    }
            } else {
                let newWorkoutID = UUID().uuidString
                workoutData["id"] = newWorkoutID
                print("Creating new workout with ID: \(newWorkoutID)")
                
                db.collection("users")
                    .document(userID)
                    .collection("workoutTemplates")
                    .document(newWorkoutID) // Use the same ID for the document
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
 // save workout()
    
}

#Preview {
    EditTemplateView(workout: nil,
                     editViewNewWorkoutPresented:Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
