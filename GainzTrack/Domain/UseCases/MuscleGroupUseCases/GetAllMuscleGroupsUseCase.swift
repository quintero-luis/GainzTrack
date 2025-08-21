//
//  File.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol GetAllMuscleGroupsUseCaseProtocol {
    func execute(for day: Day) async throws -> [MuscleGroup]
}

final class GetAllMuscleGroupsUseCase: GetAllMuscleGroupsUseCaseProtocol {
    private let repository: MuscleGroupRepositoryProtocol
    
    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(for day: Day) async throws -> [MuscleGroup] {
        return try await repository.getAllMuscleGroups(for: day)
    }
}
