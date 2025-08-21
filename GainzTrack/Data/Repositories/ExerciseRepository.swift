//
//  ExerciseRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation
import SwiftData

final class ExerciseRepository: ExerciseRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise] {
        return muscleGroup.exercises
    }
    
    func getExercise(by id: UUID) async throws -> Exercise? {
        let descriptor = FetchDescriptor<Exercise>(
            predicate: #Predicate { $0.id == id}
        )
        return try context.fetch(descriptor).first
    }
    
    func addExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws {
        muscleGroup.exercises.append(exercise)
        try context.save()
    }
    
    func updateExercise(_ exercise: Exercise) async throws {
        try context.save()
    }
    
    func deleteExercise(_ exercise: Exercise) async throws {
        context.delete(exercise)
        try context.save()
    }
}
