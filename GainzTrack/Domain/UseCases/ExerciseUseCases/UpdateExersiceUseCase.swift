//
//  UpdateExersiceUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol UpdateExerciseUseCaseProtocol {
    func execute(exercise: Exercise) async throws
}

final class UpdateExerciseUseCase: UpdateExerciseUseCaseProtocol {
    private let repository: ExerciseRepositoryProtocol
    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }
    func execute(exercise: Exercise) async throws {
        try await repository.updateExercise(exercise)
    }
}
