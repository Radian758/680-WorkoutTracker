//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Adrian Vasquez on 5/10/24.
//

import Foundation

struct Workout: Codable {
    let name: String
    let date: Date
    let exercises: [Exercise]
}
