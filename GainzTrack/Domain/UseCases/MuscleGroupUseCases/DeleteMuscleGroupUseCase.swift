//
//  DeleteMuscleGroupUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol DeleteMuscleGroupUseCaseProtocol {
    func execute(_ muscleGroup: MuscleGroup) async throws
}

final class DeleteMuscleGroupUseCase: DeleteMuscleGroupUseCaseProtocol{
    private let repository: MuscleGroupRepositoryProtocol
    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ muscleGroup: MuscleGroup) async throws {
        try await repository.deleteMuscleGroup(muscleGroup)
    }
}
