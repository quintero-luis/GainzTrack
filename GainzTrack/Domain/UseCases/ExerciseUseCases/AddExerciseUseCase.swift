//
//  AddExersiceUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol AddExerciseUseCaseProtocol {
    func execute(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws
}

final class AddExerciseUseCase: AddExerciseUseCaseProtocol {
    private let repository: ExerciseRepositoryProtocol
    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws {
        try await repository.addExercise(exercise, to: muscleGroup)
    }
}
