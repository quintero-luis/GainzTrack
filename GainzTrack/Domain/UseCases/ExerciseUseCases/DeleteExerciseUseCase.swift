//
//  DeleteExerciseUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol DeleteExerciseUseCaseProtocol {
    func execute(_ exercise: Exercise) async throws
}

final class DeleteExerciseUseCase: DeleteExerciseUseCaseProtocol {
    private let repository: ExerciseRepositoryProtocol
    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ exercise: Exercise) async throws {
        try await repository.deleteExercise(exercise)
    }
}
