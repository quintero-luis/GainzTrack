//
//  DayRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

final class DayRepository: DayRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    // Fetch all records (Day) that exist in the database (SwiftData).
    func getAllDays() async throws -> [Day] {
        let descriptor = FetchDescriptor<Day>(sortBy: [SortDescriptor(\.date)]) /// Sorted by date, in ascending order by default
        return try context.fetch(descriptor) // Returns it in a [Day] array
    }
    // Fetch the same date user wants
    func getDay(by date: Date) async throws -> Day? {
        let descriptor = FetchDescriptor<Day>(predicate: #Predicate { $0.date == date })
        return try context.fetch(descriptor).first
    }
    // Inserts a new day and saves it
    func addDay(_ day: Day) async throws {
        context.insert(day)
        return try context.save()
    }
    // Updates and saves a day
    func updateDay(_ day: Day) async throws {
        try context.save()
    }
    
    func deleteDay(_ day: Day) async throws {
        context.delete(day)
        try context.save()
    }
}
