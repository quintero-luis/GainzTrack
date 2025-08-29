//
//  ExerciseEntryRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation
import SwiftData

final class ExerciseEntryRepository: ExerciseEntryRepositoryProtocol {
    private let context: ModelContext
    init(context: ModelContext) {
        self.context = context
    }
    // Get all Exercise entries by date
    func getAllEntries(for day: Day) async throws -> [ExerciseEntry] {
        let dayID = day.persistentModelID
        let descriptor = FetchDescriptor<ExerciseEntry>(
            predicate: #Predicate { $0.day.persistentModelID == dayID }
        )
        return try context.fetch(descriptor)
    }
    
    func getEntry(by id: UUID) async throws -> ExerciseEntry? {
        let descriptor = FetchDescriptor<ExerciseEntry>(
            predicate: #Predicate { $0.id == id }
        )
        return try context.fetch(descriptor).first
    }
    
    func addEntry(_ entry: ExerciseEntry, to day: Day) async throws {
        entry.day = day
        context.insert(entry)
        try context.save()
    }
    
    func updateEntry(_ entry: ExerciseEntry) async throws {
        try context.save()
    }
    
    func deleteEntry(_ entry: ExerciseEntry) async throws {
        context.delete(entry)
        try context.save()
    }
}

final class MockExerciseEntryRepository: ExerciseEntryRepositoryProtocol {
    private var entries: [ExerciseEntry] = []
    
    init() {
        // Create day mocks
        let calendar = Calendar.current
        let today = Day(date: Date())
        let tomorrow = Day(date: calendar.date(byAdding: .day, value: 1, to: Date())!)
        let yesterday = Day(date: calendar.date(byAdding: .day, value: -1, to: Date())!)
        
        // Exercise mocks
        let benchPress = Exercise(name: "Bench Press")
        let squat = Exercise(name: "Squat")
        let latPull = Exercise(name: "Lat Pulldown")
        
        
        // Exercise Entries mocks
        let entry1 = ExerciseEntry(
            day: today,
            exercise: benchPress,
            sets: [ExerciseSet(weight: 50, reps: 10, entry: nil)]
        )
        
        let entry2 = ExerciseEntry(
            day: today,
            exercise: squat,
            sets: [ExerciseSet(weight: 80, reps: 8, entry: nil)]
        )
        
        let entry3 = ExerciseEntry(
            day: yesterday,
            exercise: latPull,
            sets: [ExerciseSet(weight: 80, reps: 6, entry: nil)]
        )
        
        let entry4 = ExerciseEntry(
            day: tomorrow,
            exercise: latPull,
            sets: [ExerciseSet(weight: 73, reps: 7, entry: nil)]
        )
        
        entries = [entry1, entry2, entry3]
    }
    
    func getAllEntries(for day: Day) async throws -> [ExerciseEntry] {
        entries.filter { $0.day.id == day.id }
    }
    
    func getEntry(by id: UUID) async throws -> ExerciseEntry? {
        entries.first { $0.id == id }
    }
    
    func addEntry(_ entry: ExerciseEntry, to day: Day) async throws {
        entry.day = day
        entries.append(entry)
    }
    
    func updateEntry(_ entry: ExerciseEntry) async throws {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
        }
    }
    
    func deleteEntry(_ entry: ExerciseEntry) async throws {
        entries.removeAll { $0.id == entry.id }
    }
}
