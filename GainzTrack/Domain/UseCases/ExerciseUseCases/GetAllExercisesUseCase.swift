//
//  GetAllExercisesUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol GetAllExercisesUseCaseProtocol {
    func execute(for muscleGroup: MuscleGroup) async throws -> [Exercise]
}

final class GetAllExercisesUseCase: GetAllExercisesUseCaseProtocol {
    private let repository: ExerciseRepositoryProtocol
    
    init(repository: ExerciseRepositoryProtocol) {
        self.repository = repository
    }
    func execute(for muscleGroup: MuscleGroup) async throws -> [Exercise] {
        return try await repository.getAllExercises(for: muscleGroup)
    }
}
