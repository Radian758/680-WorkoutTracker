//
//  EditTemplateView.swift
//  WorkoutTracker

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EditTemplateView: View {
    @State var workoutName: String = ""
    @State var exercises: [Exercise] // if workout is not nil, assign it workout.exercises
//    @StateObject var viewModel = ContentViewModel()
    let workout: Workout? // if workout is nil, create empty workout template
    @Binding var isEditViewPresented: Bool
    
    init(workout: Workout?, editViewPresented: Binding<Bool>) {
        self.workout = workout
        self._exercises = State(initialValue: workout?.exercises ?? [])
        self._isEditViewPresented = editViewPresented
    }
    
    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                // Save the workout template
//                saveWorkout()
                print("Exited EditTemplateView")
//              Disable the fullScreenCover by setting isEditViewPresented to true
                isEditViewPresented = false

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

struct ExerciseView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            TextField("Exercise Name", text: $exercise.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Add Set button
            Button(action: {
                exercise.sets.append(Set(reps: 0, weight: 0))
            }) {
                Text("Add Set")
            }
            
            // Display existing sets
            ForEach(exercise.sets.indices, id: \.self) { setIndex in
                SetView(set: $exercise.sets[setIndex])
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.vertical, 5)
    }
}

struct SetView: View {
    @Binding var set: Set
    
    var body: some View {
        HStack {
            Text("Weight:")
            TextField("Weight", value: $set.weight, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.decimalPad)
            
            Text("Reps:")
            TextField("Reps", value: $set.reps, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
        }
    }
}

#Preview {
    EditTemplateView(workout: nil, editViewPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
