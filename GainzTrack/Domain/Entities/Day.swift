//
//  DayModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

// Day in the calendar
@Model
final class Day: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    
    // Each Day can have many ExerciseEntry
    @Relationship
    var entries: [ExerciseEntry]
    
    init(id: UUID = UUID(), date: Date, entries: [ExerciseEntry] = []) {
            self.id = id
            self.date = date
            self.entries = entries
        }
}
