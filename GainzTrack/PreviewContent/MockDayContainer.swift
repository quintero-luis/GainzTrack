//
//  MockDayContainer.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import SwiftData
import Foundation

@MainActor
func mockDaysContainer() -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, configurations: config)
    let context = container.mainContext
    
    // MARK: Mock Data
    let mockDays = [
        Day(date: Date(), muscleGroups: []),
        Day(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, muscleGroups: []),
        Day(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, muscleGroups: [])
    ]
    
    for day in mockDays {
        context.insert(day)
    }
    return container
}

