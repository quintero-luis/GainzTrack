//
//  GetExerciseUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol GetExerciseUseCaseProtocol {
    func execute(by id: UUID) async throws -> Exercise?
}

final class GetExerciseUseCase: GetExerciseUseCaseProtocol {
    private let repository: ExerciseRepositoryProtocol
    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }
    func execute(by id: UUID) async throws -> Exercise? {
        return try await repository.getExercise(by: id)
    }
}
