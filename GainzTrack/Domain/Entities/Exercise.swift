//
//  ExcerciseModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

// Exercise type (Bench Press, Bicep Curl, Hack Squat, etc)
@Model
final class Exercise: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    // Inverse relationship (To which MuscleGroup does every Exercise Belongs to)
    // Each Exercise belongs to a MuscleGroup
    @Relationship(deleteRule: .nullify)
    var muscleGroup: MuscleGroup?
    
    // Relationship with ExerciseEntry (Exercise made in a day)
    @Relationship(deleteRule: .cascade)
    var entries: [ExerciseEntry] = []
    
    init(name: String) {
        self.name = name
    }
}
