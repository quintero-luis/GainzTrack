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

    func getAllEntries(for day: Day) async throws -> [ExerciseEntry] {
        let descriptor = FetchDescriptor<ExerciseEntry>(
            predicate: #Predicate { $0.day == day }
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
