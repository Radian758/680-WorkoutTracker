//
//  ExerciseView.swift
//  WorkoutTracker

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            TextField("Exercise Name", text: $exercise.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                exercise.sets.append(Set(reps: 0, weight: 0))
            }) {
                Text("Add Set")
            }
            
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

//#Preview {
//    ExerciseView()
//}
