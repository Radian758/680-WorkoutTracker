//
//  ActiveWorkoutView.swift
//  WorkoutTracker

import SwiftUI

struct ActiveWorkoutView: View {
    // @Environment(\.dismiss) var dismiss
    // dismiss() when you click on Finish Button
    
    let workout: Workout // temporary for ui building purpose
//    let workoutID: String
    
    var body: some View {
        Text("ActiveWorkoutView")
        
    }
    
    // fetchworkout() using workoutID
}

#Preview {
    ActiveWorkoutView(workout: SampleWorkouts.push)
}
