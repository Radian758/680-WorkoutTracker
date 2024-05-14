//
//  ActiveWorkoutView.swift
//  WorkoutTracker

import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct ActiveWorkoutView: View {
    @State var workoutName: String = ""
    @State var exercises: [Exercise]// if workout is not nil, assign it workout.exercises
    //    @StateObject var viewModel = ContentViewModel()
    let workout: Workout // temporary for ui building purpose
    @Environment(\.presentationMode) var presentationMode
    
    init(workout: Workout) {
        self.workout = workout
        self._exercises = State(initialValue: workout.exercises)
        self._workoutName = State(initialValue: workout.name)
        
        print("ActiveWorkoutView initialized")
    }
    
    var body: some View {
        Text("ActiveWorkoutView")
        
        HStack() {
            Spacer()
            Button(action: {
                // Save the workout to workoutHistory
                saveWorkoutToHistory(workout: workout)
                print("Exited ActiveWorkoutView")
                // Go to WorkoutHistoryView
                // WorkoutHistoryView(userId: viewModel.currentUserId)
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

#Preview {
    ActiveWorkoutView(workout: SampleWorkouts.push)
}
