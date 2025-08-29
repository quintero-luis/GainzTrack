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

final class MockExerciseSetRepository: ExerciseSetRepositoryProtocol {
    private var sets: [ExerciseSet] = []
    
    init() {
        let set1 = ExerciseSet(weight: 100, reps: 5)
        let set2 = ExerciseSet(weight: 80, reps: 6)
        let set3 = ExerciseSet(weight: 70, reps: 6)
        
        sets = [set1, set2, set3]
    }
    
    func getAllSets(for entry: ExerciseEntry) async throws -> [ExerciseSet] {
        sets.filter { $0.entry?.day.id == entry.day.id } // TODO: Maybe delete day and leave only id
    }
    
    func getSet(by id: UUID) async throws -> ExerciseSet? {
        sets.first { $0.id == id }
    }
    
    func addSet(_ set: ExerciseSet, to entry: ExerciseEntry) async throws {
        set.entry = entry
        sets.append(set)  // TODO: Test??
    }
    
    func updateSet(_ set: ExerciseSet) async throws {
        if let index = sets.firstIndex(where: { $0.id == set.id }) {
            sets[index] = set
        }
    }
    
    func deleteSet(_ set: ExerciseSet) async throws {
        sets.removeAll { $0.id == set.id }
    }
}
