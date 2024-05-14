//
//  Workout.swift
//  WorkoutTracker

import Foundation

struct Workout: Codable, Identifiable {
    let id: String
    let name: String
    let date: Date
    let exercises: [Exercise]
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id // or any other criteria for equality
    }
}
