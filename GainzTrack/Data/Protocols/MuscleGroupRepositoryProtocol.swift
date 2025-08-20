//
//  MuscleGroupRepositoryProtocol.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol MuscleGroupRepositoryProtocol {
    func getAllMuscleGroups(for day: Day) async throws -> [MuscleGroup]
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup, to day: Day) async throws
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async throws
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async throws
}
