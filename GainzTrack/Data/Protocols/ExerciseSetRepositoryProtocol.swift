//
//  ExerciseSetRepositoryProtocol.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation

protocol ExerciseSetRepositoryProtocol {
    func getAllSets(for entry: ExerciseEntry) async throws -> [ExerciseSet]
    func getSet(by id: UUID) async throws -> ExerciseSet?
    func addSet(_ set: ExerciseSet, to entry: ExerciseEntry) async throws
    func updateSet(_ set: ExerciseSet) async throws
    func deleteSet(_ set: ExerciseSet) async throws
}
