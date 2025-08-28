//
//  ExerciseSetViewModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 23/08/25.
//

import Foundation

@MainActor
final class ExerciseSetViewModel: ObservableObject {
    // MARK: Published properties
    @Published var sets: [ExerciseSet] = []
    @Published var set: ExerciseSet?
    @Published var selectedSet: ExerciseSet?
    @Published var status: Status = .none
    
    // Dependecy: ExerciseEntry selection
    private let entryMV: ExerciseEntryViewModel
    
    // ExerciseSet Use Case
    private let setUseCases: ExerciseSetUseCasesProtocol
    
    // MARK: Init
    init(entryMV: ExerciseEntryViewModel, setUseCases: ExerciseSetUseCasesProtocol) {
        self.entryMV = entryMV
        self.setUseCases = setUseCases
    }
    
    // MARK: Methods
    func fetchAllSets() async {
        guard let entry = entryMV.selectedEntry else {
            status = .error(error: "Error fetching all Exercise Sets")
            return
        }
        status = .loading
        do {
            sets = try await setUseCases.fetchAllSets(for: entry)
            // selectedSet = sets.first changed to selectedSet = set
            selectedSet = set
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func fetchSet(by id: UUID) async {
        status = .loading
        do {
            set = try await setUseCases.fetchSet(by: id)
            selectedSet = set
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func addSet(_ set: ExerciseSet) async {
        guard let entry = entryMV.selectedEntry else {
            status = .error(error: "No entry selected adding Set")
                        return
        }
        status = .loading
        do {
            try await setUseCases.createSet(set, to: entry)
            await fetchAllSets()
            selectedSet = set
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateSet(_ set: ExerciseSet) async {
        status = .loading
        do {
            try await setUseCases.updateSet(set)
            await fetchAllSets()
            selectedSet = set
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteSet(_ set: ExerciseSet? = nil) async {
        let setToDelete = set ?? selectedSet
        guard let setToDelete else {
            status = .error(error: "No set selected to delete")
            return
        }
        status = .loading
        do {
            try await setUseCases.deleteSet(setToDelete)
            await fetchAllSets() // Refresh  and bring all sets after deleting one
            // DEselect deleted set and select first set from the list
            if selectedSet?.id == setToDelete.id {
                selectedSet = sets.first
            }
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
}
