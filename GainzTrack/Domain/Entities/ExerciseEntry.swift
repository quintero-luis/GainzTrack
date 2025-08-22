//
//  ExerciseEntry.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import Foundation
import SwiftData

// Record of an exercise performed in a day
@Model
final class ExerciseEntry: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    
    // Every ExerciseEntry belongs to a day
    @Relationship(deleteRule: .nullify, inverse: \Day.exercises)
    var day: Day?
    
    // Every ExerciseEntry belongs to an Exercise
    @Relationship(deleteRule: .nullify, inverse: \Exercise.entries)
    var exercise: Exercise?
    
    // Every ExerciseEntry can have many ExerciseSets
    @Relationship(deleteRule: .cascade)
    var sets: [ExerciseSet] = []
    
    init(day: Day? = nil, exercise: Exercise? = nil) {
        self.day = day
        self.exercise = exercise
    }
}
