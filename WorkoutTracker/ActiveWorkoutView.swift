//
//  ActiveWorkoutView.swift
//  WorkoutTracker

import SwiftUI

struct ActiveWorkoutView: View {
    let workout: Workout
    
    var body: some View {
        Text("ActiveWorkoutView")
    }
}

#Preview {
    ActiveWorkoutView(workout: SampleWorkouts.push)
}
