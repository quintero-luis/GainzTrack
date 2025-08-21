//
//  AddMuscleGroupUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol AddMuscleGroupUseCaseProtocol {
    func execute(_ muscleGroup: MuscleGroup, to day: Day) async throws
}

final class AddMuscleGroupUseCase: AddMuscleGroupUseCaseProtocol {
    private let repository: MuscleGroupRepositoryProtocol
    
    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ muscleGroup: MuscleGroup, to day: Day) async throws {
        try await repository.addMuscleGroup(muscleGroup, to: day)
    }
}
