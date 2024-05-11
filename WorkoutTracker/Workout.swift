//
//  Workout.swift
//  WorkoutTracker

import Foundation

struct Workout: Codable, Identifiable {
    var id = UUID()
    let name: String
    let date: Date
    let exercises: [Exercise]
}
