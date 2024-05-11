//
//  SampleWorkouts.swift
//  WorkoutTracker

import Foundation

class SampleWorkouts {
    
    static let workouts: [Workout] = [push, legs]
    
    static let push: Workout = {
          let exercises = [
              Exercise(name: "Bench Press", sets: [
                  Set(reps: 4, weight: 200),
                  Set(reps: 4, weight: 200),
                  Set(reps: 4, weight: 200),
                  Set(reps: 4, weight: 200)
              ]),
              Exercise(name: "Incline Bench Press", sets: [
                  Set(reps: 2, weight: 180),
                  Set(reps: 2, weight: 180)
              ]),
              Exercise(name: "Lateral Raise", sets: [
                  Set(reps: 3, weight: 30),
                  Set(reps: 3, weight: 30),
                  Set(reps: 3, weight: 30)
              ]),
              Exercise(name: "Skullcrushers", sets: [
                  Set(reps: 4, weight: 60),
                  Set(reps: 4, weight: 60),
                  Set(reps: 4, weight: 60),
                  Set(reps: 4, weight: 60)
              ])
          ]
          
          return Workout(name: "Push", date: Date(), exercises: exercises)
      }()
    static let legs: Workout = {
        let exercises = [
            Exercise(name: "Squats", sets: [
                Set(reps: 5, weight: 225),
                Set(reps: 5, weight: 245),
                Set(reps: 5, weight: 265)
            ]),
            Exercise(name: "Leg Press", sets: [
                Set(reps: 8, weight: 360),
                Set(reps: 8, weight: 360),
                Set(reps: 8, weight: 360)
            ]),
            Exercise(name: "Romanian Deadlifts", sets: [
                Set(reps: 10, weight: 185),
                Set(reps: 10, weight: 185),
                Set(reps: 10, weight: 185)
            ]),
            Exercise(name: "Leg Extensions", sets: [
                Set(reps: 12, weight: 90),
                Set(reps: 12, weight: 90),
                Set(reps: 12, weight: 90)
            ])
        ]
        
        return Workout(name: "Legs", date: Date(), exercises: exercises)
    }()
}
