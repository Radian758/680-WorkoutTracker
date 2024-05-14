//
//  ActiveWorkoutView.swift
//  WorkoutTracker

//import FirebaseFirestore
//import FirebaseAuth
import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel: ActiveWorkoutViewModel
    let workout: Workout // temporary for ui building purpose
    @Environment(\.presentationMode) var presentationMode
    
    init(workout: Workout) {
        self.workout = workout
//        self._exercises = State(initialValue: workout.exercises)
//        self._workoutName = State(initialValue: workout.name)
        self._viewModel = StateObject(
            wrappedValue: ActiveWorkoutViewModel(workout: workout)
        )
        print("ActiveWorkoutView initialized")
    }
    
    var body: some View {
        Text("ActiveWorkoutView")
        
        HStack() {
            Spacer()
            Button(action: {
                // Save the workout to workoutHistory
                viewModel.saveWorkoutToHistory(workout: workout)
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
                TextField("Workout Template Name", text: $viewModel.workoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Add Exercise button
                Button(action: {
                    viewModel.exercises.append(Exercise(name: "", sets: []))
                }) {
                    Text("Add Exercise")
                }
                
                // Display existing exercises
                ForEach(viewModel.exercises.indices, id: \.self) { index in
                    ExerciseView(exercise: $viewModel.exercises[index])
                }
            }
            .padding()
        }
    }
    

    
}

#Preview {
    ActiveWorkoutView(workout: SampleWorkouts.push)
}
