//
//  ExerciseSetUseCases.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation

protocol ExerciseSetUseCasesProtocol {
    func fetchAllSets(for entry: ExerciseEntry) async throws -> [ExerciseSet]
    func fetchSet(by id: UUID) async throws -> ExerciseSet?
    func createSet(_ set: ExerciseSet, to entry: ExerciseEntry) async throws
    func updateSet(_ set: ExerciseSet) async throws
    func deleteSet(_ set: ExerciseSet) async throws
}

final class ExerciseSetUseCases: ExerciseSetUseCasesProtocol {
    private let repository: ExerciseSetRepositoryProtocol

    init(repository: ExerciseSetRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAllSets(for entry: ExerciseEntry) async throws -> [ExerciseSet] {
        try await repository.getAllSets(for: entry)
    }

    func fetchSet(by id: UUID) async throws -> ExerciseSet? {
        try await repository.getSet(by: id)
    }

    // Create a set for an ExerciseEntry
    func createSet(_ set: ExerciseSet, to entry: ExerciseEntry) async throws {
        try await repository.addSet(set, to: entry)
    }

    func updateSet(_ set: ExerciseSet) async throws {
        try await repository.updateSet(set)
    }

    func deleteSet(_ set: ExerciseSet) async throws {
        try await repository.deleteSet(set)
    }
}
