//
//  Set.swift
//  WorkoutTracker

import Foundation

struct Set: Codable, Identifiable {
    var id = UUID()
    var reps: Int
    var weight: Double
}
