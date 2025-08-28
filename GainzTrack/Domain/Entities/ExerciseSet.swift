//
//  ExerciseSet.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import Foundation
import SwiftData

// Each specific set of an exercise
@Model
final class ExerciseSet: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var weight: Double
    var reps: Int
    var weightUnit: String = ""
    
    // Every ExerciseSet belongs to an ExerciseEntry
    @Relationship(deleteRule: .nullify, inverse: \ExerciseEntry.sets)
    var entry: ExerciseEntry?
    
    init(weight: Double, reps: Int, entry: ExerciseEntry? = nil) {
        self.weight = weight
        self.reps = reps
        self.entry = entry
    }
}
