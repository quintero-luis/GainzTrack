//
//  ExcerciseModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

@Model
final class Exercise: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var reps: Int
    var weight: Double
    
    init(name: String, reps: Int, weight: Double) {
        self.name = name
        self.reps = reps
        self.weight = weight
    }
}
