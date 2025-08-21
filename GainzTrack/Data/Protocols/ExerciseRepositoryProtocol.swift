//
//  ExerciseRepositoryProtocol.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol ExerciseRepositoryProtocol {
    func getAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise]
    func getExercise(by id: UUID) async throws -> Exercise?
    func addExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws
    func updateExercise(_ exercise: Exercise) async throws
    func deleteExercise(_ exercise: Exercise) async throws
}
