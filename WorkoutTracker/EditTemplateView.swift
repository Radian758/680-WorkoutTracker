//
//  EditTemplateView.swift
//  WorkoutTracker

import SwiftUI

struct EditTemplateView: View {
    let workout: Workout? // if workout is nil, create empty workout template
    @Binding var isEditViewNewWorkoutPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel:  EditTemplateViewModel
    
    init(workout: Workout?, editViewNewWorkoutPresented: Binding<Bool>) {
        self.workout = workout
        self._isEditViewNewWorkoutPresented = editViewNewWorkoutPresented
        
        if let workout = workout {
            self._viewModel = StateObject(
                wrappedValue: EditTemplateViewModel(workout: workout)
            )
        } else {
            self._viewModel = StateObject(
                wrappedValue: EditTemplateViewModel(workout: nil)
            )
        }
    }
    
    var body: some View {
        Text("Edit Template")
        HStack() {
            Spacer()
            Button(action: {
                viewModel.saveWorkout()
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
                TextField("Workout Template Name", text: $viewModel.workoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
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
    EditTemplateView(workout: nil,
                     editViewNewWorkoutPresented:Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
