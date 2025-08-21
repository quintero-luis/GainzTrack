//
//  MuscleGroupRepository.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation
import SwiftData

final class MuscleGroupRepository: MuscleGroupRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    // TODO:
    /*
     func getAllMuscleGroups(for day: Day) async throws -> [MuscleGroup] {
         let descriptor = FetchDescriptor<MuscleGroup>(
             predicate: #Predicate { $0.day == day } // si agregas la relación inversa day en MuscleGroup
         )
         return try context.fetch(descriptor)
     }
     */
    
    func getAllMuscleGroups(for day: Day) async throws -> [MuscleGroup] {
        return day.muscleGroups
    }
    
    func getMuscleGroup(by id: UUID) async throws -> MuscleGroup? {
        let descriptor = FetchDescriptor<MuscleGroup>(
            predicate: #Predicate { $0.id == id}
        )
        
        return try context.fetch(descriptor).first
    }
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup, to day: Day) async throws {
        day.muscleGroups.append(muscleGroup)
        try context.save()
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        try context.save()
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        context.delete(muscleGroup)
        try context.save()
    }
}
