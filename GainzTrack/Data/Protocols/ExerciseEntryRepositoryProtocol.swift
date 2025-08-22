//
//  ExerciseEntryRepositoryProtocol.swift
//  GainzTrack
//
//  Created by Luis Quintero on 22/08/25.
//

import Foundation

protocol ExerciseEntryRepositoryProtocol {
    func getAllEntries(for day: Day) async throws -> [ExerciseEntry]
    func getEntry(by id: UUID) async throws -> ExerciseEntry?
    func addEntry(_ entry: ExerciseEntry, to day: Day) async throws
    func updateEntry(_ entry: ExerciseEntry) async throws
    func deleteEntry(_ entry: ExerciseEntry) async throws
}
