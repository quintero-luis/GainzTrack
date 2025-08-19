//
//  DayModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

@Model
final class Day {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    @Relationship(deleteRule: .cascade) var muscleGroups: [MuscleGroup] = []
    
    init(date: Date, muscleGroups: [MuscleGroup]) {
        self.date = date
        self.muscleGroups = muscleGroups
    }
}
