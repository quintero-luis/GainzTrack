//
//  AddMuscleGroupUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol MuscleGroupUseCasesProtocol {
    func fetchAllMuscleGroups() async throws -> [MuscleGroup]
    func fetchMuscleGroup(by id: UUID) async throws -> MuscleGroup?
    func createMuscleGroup(_ muscleGroup: MuscleGroup) async throws
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws
}

final class MuscleGroupUseCases: MuscleGroupUseCasesProtocol {
    private let repository: MuscleGroupRepositoryProtocol

    init(repository: MuscleGroupRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAllMuscleGroups() async throws -> [MuscleGroup] {
        try await repository.getAllMuscleGroups()
    }

    func fetchMuscleGroup(by id: UUID) async throws -> MuscleGroup? {
        try await repository.getMuscleGroup(by: id)
    }

    func createMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.addMuscleGroup(muscleGroup)
    }

    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.updateMuscleGroup(muscleGroup)
    }

    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.deleteMuscleGroup(muscleGroup)
    }
}

final class MuscleGroupUseCaseMock: MuscleGroupUseCasesProtocol {
    private var repository: MockMuscleGroupRepository

    init(repository: MockMuscleGroupRepository = MockMuscleGroupRepository()) {
        self.repository = repository
    }
    
    func fetchAllMuscleGroups() async throws -> [MuscleGroup] {
        try await repository.getAllMuscleGroups()
    }
    
    func fetchMuscleGroup(by id: UUID) async throws -> MuscleGroup? {
        try await repository.getMuscleGroup(by: id)
    }
    
    func createMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.addMuscleGroup(muscleGroup)
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.updateMuscleGroup(muscleGroup)
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try await repository.deleteMuscleGroup(muscleGroup)
    }  
}

