//
//  MuscleGroupModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

@Model
final class MuscleGroup {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    @Relationship(deleteRule: .cascade) var exercises: [Exercise] = []
    
    init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
}
