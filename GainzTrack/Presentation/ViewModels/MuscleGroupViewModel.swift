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
    
    private let daysVM: DayViewModel
    
    // MARK: Muscle Group VM Use Cases
    private let addMuscleGroupUseCase: AddMuscleGroupUseCase
    private let deleteMuscleGroupUseCase: DeleteMuscleGroupUseCase
    private let getAllMuscleGroupsUseCase: GetAllMuscleGroupsUseCase
    private let getMuscleGroupUseCase: GetMuscleGroupUseCase
    private let updateMuscleGroupUseCase: UpdateMuscleGroupUseCase
    
    // MARK: Muscle Group VM Init
    init(addMuscleGroupUseCase: AddMuscleGroupUseCase,
         deleteMuscleGroupUseCase: DeleteMuscleGroupUseCase,
         getAllMuscleGroupsUseCase: GetAllMuscleGroupsUseCase,
         getMuscleGroupUseCase: GetMuscleGroupUseCase,
         updateMuscleGroupUseCase: UpdateMuscleGroupUseCase,
         daysVM: DayViewModel
    ) {
        self.addMuscleGroupUseCase = addMuscleGroupUseCase
        self.deleteMuscleGroupUseCase = deleteMuscleGroupUseCase
        self.getAllMuscleGroupsUseCase = getAllMuscleGroupsUseCase
        self.getMuscleGroupUseCase = getMuscleGroupUseCase
        self.updateMuscleGroupUseCase = updateMuscleGroupUseCase
        self.daysVM = daysVM
    }
    
    // MARK: Muscle Group VM Methods
    func fetchAllMuscleGroups() async {
        guard let day = daysVM.selectedDay else { return } // TODO: See if it is better to change return
        status = .loading
        do {
            muscleGroups = try await getAllMuscleGroupsUseCase.execute(for: day)
            // TODO: Check when UI testing
            /*
             This automatically selects the first muscle in the list after loading the muscleGroups.

             Purpose: If your UI has details or actions based on the selected muscle, there will always be a default value.

             Without this, selectedMuscleGroup would be nil until the user taps a muscle.
             */
            selectedMuscleGroup = muscleGroups.first
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    // TODO: See if we need to add for day: Day
    func fetchMuscleGroup(by id: UUID) async {
        status = .loading
        do {
            muscleGroup = try await getMuscleGroupUseCase.execute(by: id)
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func addMuscleGroup(_ muscleGroup: MuscleGroup) async {
        guard let day = daysVM.selectedDay else {
            status = .error(error: "No day selected adding MuscleGroup")
            return }
        status = .loading
        do {
            try await addMuscleGroupUseCase.execute(muscleGroup, to: day)
            /*muscleGroups.append(muscleGroup)*/ // // Refresh musclegroups after adding
            await fetchAllMuscleGroups() // Refresh musclegroups after adding
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup) async {
        guard let day = daysVM.selectedDay else {
            status = .error(error: "No day selected deleting Muscle Group")
            return
        }
        status = .loading
        do {
            try await deleteMuscleGroupUseCase.execute(muscleGroup)
            await fetchAllMuscleGroups() // Refresh musclegroups after deleting
            
            // if -> used to DEselect deleted object, and select the first object from the list
            // TODO: Check in testing if we need to add ?.id and .id
            if selectedMuscleGroup == muscleGroup {
                selectedMuscleGroup = muscleGroups.first
            }
            
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup) async {
        guard let day = daysVM.selectedDay else {
            status = .error(error: "No day selected updating Muscle Group")
            return
        }
        status = .loading
        do {
            try await updateMuscleGroupUseCase.execute(muscleGroup: muscleGroup)
            await fetchAllMuscleGroups() // Refresh musclegroups after updating
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
}


