//
//  EditTemplateView.swift
//  WorkoutTracker

import SwiftUI
import FirebaseFirestore

struct EditTemplateView: View {
    @State var workoutName: String = ""
    // fetch exercises from db
    // if exercises is NIL, create empty array
    @State var exercises: [Exercise] = []
    @StateObject var viewModel = ContentViewModel()
    
    let workoutID: String // ID of the workout to fetch
    
    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                // Go back to TemplatesView
                print("Go to TemplatesView")
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
            .onAppear {
                fetchWorkout()
            }
            .padding()
        }
    }
    
    func fetchWorkout() {
        print("Fetching workout...")
//        let db = Firestore.firestore()
//        let workoutRef = db.collection("workouts").document(workoutID)

    }
    
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
    EditTemplateView(workoutID: "")
}
