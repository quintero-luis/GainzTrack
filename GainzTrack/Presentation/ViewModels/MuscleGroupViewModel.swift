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
    @Published var status: Status = .none
    
    @Published var selectedDay: Day?
    
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
         updateMuscleGroupUseCase: UpdateMuscleGroupUseCase
    ) {
        self.addMuscleGroupUseCase = addMuscleGroupUseCase
        self.deleteMuscleGroupUseCase = deleteMuscleGroupUseCase
        self.getAllMuscleGroupsUseCase = getAllMuscleGroupsUseCase
        self.getMuscleGroupUseCase = getMuscleGroupUseCase
        self.updateMuscleGroupUseCase = updateMuscleGroupUseCase
    }
    
    // MARK: Muscle Group VM Methods
    func fetchAllMuscleGroups() async {
        guard let day = selectedDay else { return } // TODO: See if it is better to change return
        status = .loading
        do {
            muscleGroups = try await getAllMuscleGroupsUseCase.execute(for: day)
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
        guard let day = selectedDay else { return }
        status = .loading
        do {
            try await addMuscleGroupUseCase.execute(muscleGroup, to: day)
            await fetchAllMuscleGroups() // // Refresh musclegroups after adding
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteMuscleGroup(_ muscleGroup: MuscleGroup, for day: Day) async {
        guard let day = selectedDay else { return }
        status = .loading
        do {
            try await deleteMuscleGroupUseCase.execute(muscleGroup)
            await fetchAllMuscleGroups() // Refresh musclegroups after deleting
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateMuscleGroup(_ muscleGroup: MuscleGroup, for day: Day) async {
        guard let day = selectedDay else { return }
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
