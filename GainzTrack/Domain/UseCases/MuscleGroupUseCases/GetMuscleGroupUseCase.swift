//
//  GetMuscleGroup.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol GetMuscleGroupUseCaseProtocol {
    func execute(by id: UUID) async throws -> MuscleGroup?
}

final class GetMuscleGroupUseCase: GetMuscleGroupUseCaseProtocol {
    private let repository: MuscleGroupRepositoryProtocol
    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }
    func execute(by id: UUID) async throws -> MuscleGroup? {
        return try await repository.getMuscleGroup(by: id)
    }
}
