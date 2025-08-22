//
//  MuscleGroupModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

@Model
final class MuscleGroup: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    // Every MuscleGroup can have many Exercises
    @Relationship(deleteRule: .cascade)
    var exercises: [Exercise] = []
    
    init(name: String) {
            self.name = name
        }
}
