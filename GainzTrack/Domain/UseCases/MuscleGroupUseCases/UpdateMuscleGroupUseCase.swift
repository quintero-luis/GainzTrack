//
//  UpdateMuscleGroupUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol UpdateMuscleGroupUseCaseProtocol {
    func execute(muscleGroup: MuscleGroup) async throws
}

final class UpdateMuscleGroupUseCase: UpdateMuscleGroupUseCaseProtocol {
    private let repository: MuscleGroupRepositoryProtocol
    
    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }
    func execute(muscleGroup: MuscleGroup) async throws {
        try await repository.updateMuscleGroup(muscleGroup)
    }
}
