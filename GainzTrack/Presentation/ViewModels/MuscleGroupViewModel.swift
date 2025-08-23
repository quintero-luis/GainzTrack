//
//  MuscleGroupViewModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import Foundation

@MainActor
final class MuscleGroupViewModel: ObservableObject {
    // MARK: Muscle Group VM Published properties
    @Published var muscleGroups: [MuscleGroup] = []
    @Published var muscleGroup: MuscleGroup?
    @Published var selectedMuscleGroup: MuscleGroup?
    @Published var status: Status = .none
        
    // MARK: Muscle Group VM Use Cases
    private let muscleGroupUseCases: MuscleGroupUseCasesProtocol

    
    // MARK: Muscle Group VM Init
    init(muscleGroupUseCases: MuscleGroupUseCasesProtocol) {
        self.muscleGroupUseCases = muscleGroupUseCases
    }
    
    // MARK: Muscle Group VM Methods
    func fetchAllMuscleGroups() async {
        status = .loading
        do {
            muscleGroups = try await muscleGroupUseCases.fetchAllMuscleGroups()
            selectedMuscleGroup = muscleGroups.first
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func fetchMuscleGroup(by id: UUID) async {
        status = .loading
        do {
            muscleGroup = try await muscleGroupUseCases.fetchMuscleGroup(by: id)
            selectedMuscleGroup = muscleGroup
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup) async {
        status = .loading
        do {
            try await muscleGroupUseCases.createMuscleGroup(muscleGroup)
            await fetchAllMuscleGroups() // Refresh musclegroups after adding
            selectedMuscleGroup = muscleGroup
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup? = nil) async {
        let muscleGroupToDelete = muscleGroup ?? selectedMuscleGroup
        guard let muscleGroupToDelete else {
            status = .error(error: "No muscle group selected deleting Muscle Group")
            return
        }
        
        status = .loading
        do {
            try await muscleGroupUseCases.deleteMuscleGroup(muscleGroupToDelete)
            await fetchAllMuscleGroups() // Refresh musclegroups after deleting
            
            // if -> used to DEselect deleted object, and select the first object from the list
            if selectedMuscleGroup?.id == muscleGroupToDelete.id {
                selectedMuscleGroup = muscleGroups.first
            }
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async {
        status = .loading
        do {
            try await muscleGroupUseCases.updateMuscleGroup(muscleGroup)
            await fetchAllMuscleGroups() // Refresh musclegroups after updating
            selectedMuscleGroup = muscleGroup
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
}


