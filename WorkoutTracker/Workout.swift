//
//  Workout.swift
//  WorkoutTracker

import Foundation

struct Workout: Codable {
    let name: String
    let date: Date
    let exercises: [Exercise]
}
