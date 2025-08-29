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

final class ExerciseUseCaseMock: ExerciseUseCasesProtocol {
    
    // Mock storage para simular ejercicios
    private var exercises: [Exercise] = [
        Exercise(name: "Bench Press"),
        Exercise(name: "Pull Up"),
        Exercise(name: "Squat")
    ]
    
    func fetchAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise] {
        exercises
    }
    
    func createExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws {
        exercises.append(exercise)
    }
    
    func fetchExercise(by id: UUID) async throws -> Exercise? {
        exercises.first { $0.id == id }
    }
    
    func updateExercise(_ exercise: Exercise) async throws {
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
        }
    }
    
    func deleteExercise(_ exercise: Exercise) async throws {
        exercises.removeAll { $0.id == exercise.id }
    }
}
