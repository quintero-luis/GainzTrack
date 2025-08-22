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
    // Fetch all exercises for a given MuscleGroup using context
    func getAllExercises(for muscleGroup: MuscleGroup) async throws -> [Exercise] {
        let descriptor = FetchDescriptor<Exercise>(
            predicate: #Predicate { $0.muscleGroup == muscleGroup}
        )
        return try context.fetch(descriptor)
    }
    
    // Fetch by unique ID
    func getExercise(by id: UUID) async throws -> Exercise? {
        let descriptor = FetchDescriptor<Exercise>(
            predicate: #Predicate { $0.id == id}
        )
        return try context.fetch(descriptor).first
    }
    
    // Add an exercise and link to muscle group
    func addExercise(_ exercise: Exercise, to muscleGroup: MuscleGroup) async throws {
        exercise.muscleGroup = muscleGroup
        context.insert(exercise)
        try context.save()
    }
    
    // Update (just save, SwiftData tracks changes)
    func updateExercise(_ exercise: Exercise) async throws {
        try context.save()
    }
    
    // Delete from context and save
    func deleteExercise(_ exercise: Exercise) async throws {
        context.delete(exercise)
        try context.save()
    }
}
