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
    
    func getAllMuscleGroups() async throws -> [MuscleGroup] {
        let descriptor = FetchDescriptor<MuscleGroup>(
            sortBy: [SortDescriptor(\.name)] // Sort alphabetically
        )
        return try context.fetch(descriptor)
    }
    
    func getMuscleGroup(by id: UUID) async throws -> MuscleGroup? {
        let descriptor = FetchDescriptor<MuscleGroup>(
            predicate: #Predicate { $0.id == id}
        )
        
        return try context.fetch(descriptor).first
    }
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        context.insert(muscleGroup)
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

final class MockMuscleGroupRepository: MuscleGroupRepositoryProtocol {
    
    private var muscleGroups: [MuscleGroup] = []
    
    init() {
        let muscle1 = MuscleGroup(name: "Chest")
        let muscle2 = MuscleGroup(name: "Legs")
        let muscle3 = MuscleGroup(name: "Back")
        
        muscleGroups = [muscle1, muscle2, muscle3]
    }
    
    func getAllMuscleGroups() async throws -> [MuscleGroup] {
        muscleGroups
    }
    
    func getMuscleGroup(by id: UUID) async throws -> MuscleGroup? {
        muscleGroups.first { $0.id == id }
    }
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        muscleGroups.append(muscleGroup)
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        if let index = muscleGroups.firstIndex(where: { $0.id == muscleGroup.id }) {
            muscleGroups[index] = muscleGroup
        }
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws {
        muscleGroups.removeAll { $0.id == muscleGroup.id }
    }
}


