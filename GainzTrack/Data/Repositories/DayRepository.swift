//
//  DayRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

@MainActor
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
        try context.save()
    }
    
    // Updates and saves a day
    func updateDay(_ day: Day) async throws {
        try context.save()
    }
    
    func deleteDay(_ day: Day) async throws {
        context.delete(day)
        try context.save()
    }
    
    /// Ensures there is a Day for today. Returns it.
        func getOrCreateToday() async throws -> Day {
            let todayDate = Calendar.current.startOfDay(for: Date())
            if let today = try await getDay(by: todayDate) {
                return today
            } else {
                let newDay = Day(date: todayDate)
                try await addDay(newDay)
                return newDay
            }
        }
}

final class MockDayRepository: DayRepositoryProtocol {
    private var days: [Day] = []

    init() {
        // Crear días de prueba: hace 2 días, ayer y hoy
        let calendar = Calendar.current
        days = [
            Day(date: calendar.date(byAdding: .day, value: -2, to: Date())!),
            Day(date: calendar.date(byAdding: .day, value: -1, to: Date())!),
            Day(date: calendar.date(byAdding: .day, value: 1, to: Date())!),
            Day(date: calendar.startOfDay(for: Date()))
        ]
    }
    
    func getAllDays() async throws -> [Day] {
        days
    }
    
//    func getDay(by date: Date) async throws -> Day? {
//        days.first { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }
//    }
    func getDay(by date: Date) async throws -> Day? {
        let calendar = Calendar.current
        return days.first { calendar.isDate($0.date, equalTo: date, toGranularity: .day) }
    }
    
    func addDay(_ day: Day) async throws {
        days.append(day)
    }
    
    func updateDay(_ day: Day) async throws {
        if let index = days.firstIndex(where: { $0.id == day.id }) {
            days[index] = day
        }
    }
    
    func deleteDay(_ day: Day) async throws {
        days.removeAll { $0.id == day.id }
    }
    
    func getOrCreateToday() async throws -> Day {
        let todayDate = Calendar.current.startOfDay(for: Date())
        if let today = try await getDay(by: todayDate) {
            return today
        } else {
            let newDay = Day(date: todayDate)
            try await addDay(newDay)
            return newDay
        }
    }
}

//final class MockDayRepository: DayRepositoryProtocol {
//    private var days: [Day] = []
//    
//    
//    func getAllDays() async throws -> [Day] {
//        days
//    }
//    
//    func getDay(by date: Date) async throws -> Day? {
//        days.first { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day)}
//    }
//    
//    func addDay(_ day: Day) async throws {
//        days.append(day)
//    }
//    
//    func updateDay(_ day: Day) async throws {
//        if let index = days.firstIndex(where: { $0.id == day.id }) {
//            days[index] = day
//        }
//    }
//    
//    func deleteDay(_ day: Day) async throws {
//        days.removeAll { $0.id == day.id }
//    }
//    
//    func getOrCreateToday() async throws -> Day {
//        //Today date and reuse getDay(by:)
//        let todayDate = Calendar.current.startOfDay(for: Date())
//        if let today = try await getDay(by: todayDate) {
//            return today
//        } else {
//            let newDay = Day(date: todayDate)
//            try await addDay(newDay)
//            return newDay
//        }
//    }
//}
