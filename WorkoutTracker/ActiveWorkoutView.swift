//
//  ActiveWorkoutView.swift
//  WorkoutTracker

import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel: ActiveWorkoutViewModel
    let workout: Workout // temporary for ui building purpose
    @Environment(\.presentationMode) var presentationMode
    
    init(workout: Workout) {
        self.workout = workout
        self._viewModel = StateObject(
            wrappedValue: ActiveWorkoutViewModel(workout: workout)
        )
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
                
                Button(action: {
                    viewModel.exercises.append(Exercise(name: "", sets: []))
                }) {
                    Text("Add Exercise")
                }
                
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
