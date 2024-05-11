//
//  TemplateView.swift
//  WorkoutTracker

import SwiftUI

struct TemplateView: View {
    let workout: Workout
    
    
    var body: some View {
        VStack {
            Text("Sample Workout Template: \(workout.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            ForEach(workout.exercises) { exercise in
                TemplateExerciseView(exercise: exercise)
                    .padding(.vertical, 10)
            }
        }
        .padding()
    }
}

struct TemplateExerciseView: View {
    let exercise: Exercise
    
    var body: some View {
        HStack {
            Text("\(exercise.sets.count)x")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(exercise.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

//#Preview {
//    TemplateView()
//}
