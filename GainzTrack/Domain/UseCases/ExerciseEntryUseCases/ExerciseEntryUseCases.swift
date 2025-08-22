//
//  ExerciseEntryUseCases.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation

protocol ExerciseEntryUseCasesProtocol {
    func fetchAllEntries(for day: Day) async throws -> [ExerciseEntry]
    func fetchEntry(by id: UUID) async throws -> ExerciseEntry?
    func createEntry(_ entry: ExerciseEntry, to day: Day) async throws
    func updateEntry(_ entry: ExerciseEntry) async throws
    func deleteEntry(_ entry: ExerciseEntry) async throws
}

final class ExerciseEntryUseCases: ExerciseEntryUseCasesProtocol {
    private let repository: ExerciseEntryRepositoryProtocol

    init(repository: ExerciseEntryRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAllEntries(for day: Day) async throws -> [ExerciseEntry] {
        try await repository.getAllEntries(for: day)
    }

    func fetchEntry(by id: UUID) async throws -> ExerciseEntry? {
        try await repository.getEntry(by: id)
    }

    // Creates an ExerciseEntry for a specific Day
    func createEntry(_ entry: ExerciseEntry, to day: Day) async throws {
        try await repository.addEntry(entry, to: day)
    }

    func updateEntry(_ entry: ExerciseEntry) async throws {
        try await repository.updateEntry(entry)
    }

    func deleteEntry(_ entry: ExerciseEntry) async throws {
        try await repository.deleteEntry(entry)
    }
}
