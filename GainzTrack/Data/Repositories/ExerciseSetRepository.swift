//
//  ExerciseSetRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation
import SwiftData

final class ExerciseSetRepository: ExerciseSetRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getAllSets(for entry: ExerciseEntry) async throws -> [ExerciseSet] {
        let entryID = entry.persistentModelID
        let descriptor = FetchDescriptor<ExerciseSet>(
            predicate: #Predicate { $0.entry?.persistentModelID == entryID}
        )
        return try context.fetch(descriptor)
    }

    func getSet(by id: UUID) async throws -> ExerciseSet? {
        let descriptor = FetchDescriptor<ExerciseSet>(
            predicate: #Predicate { $0.id == id }
        )
        return try context.fetch(descriptor).first
    }

    func addSet(_ set: ExerciseSet, to entry: ExerciseEntry) async throws {
        set.entry = entry
        context.insert(set)
        try context.save()
    }

    func updateSet(_ set: ExerciseSet) async throws {
        try context.save()
    }

    func deleteSet(_ set: ExerciseSet) async throws {
        context.delete(set)
        try context.save()
    }
}
