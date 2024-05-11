//
//  Exercise.swift
//  WorkoutTracker

import Foundation

struct Exercise: Codable, Identifiable {
    var id = UUID()
    var name: String
    var sets: [Set]
}
