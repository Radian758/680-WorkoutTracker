//
//  EditTemplateView.swift
//  WorkoutTracker

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EditTemplateView: View {
    @State var workoutName: String = ""
    @State var exercises: [Exercise]// if workout is not nil, assign it workout.exercises
//    @StateObject var viewModel = ContentViewModel()
    let workout: Workout? // if workout is nil, create empty workout template
    @Binding var isEditViewFromPlusPresented: Bool
    @Binding var isEditViewFromKebabPresented: Bool
    
    init(workout: Workout?, editViewFromPlusPresented: Binding<Bool>, editViewFromKebabPresented: Binding<Bool>) {
        self.workout = workout
        self._isEditViewFromPlusPresented = editViewFromPlusPresented
        self._isEditViewFromKebabPresented = editViewFromKebabPresented
        if let workout = workout {
            print("workout is not nil!")
        } else {
            print("workout is nil: \(workout)")
        }
        self._exercises = State(initialValue: workout?.exercises ?? [])
        print("EditTemplateView initialized")
    }
    
    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                // Save the workout template
//                saveWorkout()
                print("Exited EditTemplateView")
//              Disable the fullScreenCover by setting isEditViewPresented to true
//                isEditViewPresented = false
                isEditViewFromPlusPresented = false
                isEditViewFromKebabPresented = false

                //                WorkoutHistoryView(userId: viewModel.currentUserId)
                
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
//            .onAppear {
//                 // Ensure workout and its exercises are not nil
//                 if let workout = workout {
//                     print("workout is not nil!")
//                     exercises = workout.exercises
//                 } else {
//                     print("workout is nil: \(workout)")
//                 }
//             }
            .padding()
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
                    // Convert exercises to Firestore-compatible data
                    "exercises": exercises.map { $0.asDictionary() }
                ]
                
                if let workout = workout {
                    // Update existing workout
                    db.collection("users")
                        .document(userID)
                        .collection("workouts")
                        .document(workout.id.uuidString)
                        .setData(workoutData) { error in
                        if let error = error {
                            print("Error updating workout: \(error.localizedDescription)")
                        } else {
                            print("Workout updated successfully")
                        }
                    }
                } else {
                    // Create new workout
                    db.collection("users")
                        .document(userID)
                        .collection("workouts")
                        .addDocument(data: workoutData) { error in
                        if let error = error {
                            print("Error adding workout: \(error.localizedDescription)")
                        } else {
                            print("Workout added successfully")
                        }
                    }
                }
            } else {
                print("No user is currently signed in")
            }

        } // saveWorkout()
    
}

//#Preview {
//    EditTemplateView(workout: nil, editViewPresented: Binding(get: {
//        return true
//    }, set: { _ in
//        
//    }))
//}
