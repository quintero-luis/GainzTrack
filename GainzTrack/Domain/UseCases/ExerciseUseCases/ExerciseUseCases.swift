//
//  AddExersiceUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol ExerciseUseCasesProtocol {
    func fetchAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise]
    func fetchExercise(by id: UUID) async throws -> Exercise?
    func createExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws
    func updateExercise(_ exercise: Exercise) async throws
    func deleteExercise(_ exercise: Exercise) async throws
}

final class ExerciseUseCases: ExerciseUseCasesProtocol {
    private let repository: ExerciseRepositoryProtocol

    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise] {
        try await repository.getAllExercises(for: muscleGroup)
    }

    func fetchExercise(by id: UUID) async throws -> Exercise? {
        try await repository.getExercise(by: id)
    }

    func createExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws {
        try await repository.addExercise(exercise, to: muscleGroup)
    }

    func updateExercise(_ exercise: Exercise) async throws {
        try await repository.updateExercise(exercise)
    }

    func deleteExercise(_ exercise: Exercise) async throws {
        try await repository.deleteExercise(exercise)
    }
}
