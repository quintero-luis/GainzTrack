//
//  ExerciseEntryViewModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 23/08/25.
//

import Foundation
 // TODO: See if weak needed
@MainActor
final class ExerciseEntryViewModel: ObservableObject {
    // MARK: Published properties
    @Published var entries: [ExerciseEntry] = []
    @Published var entry: ExerciseEntry?
    @Published var selectedEntry: ExerciseEntry?
    @Published var status: Status = .none
    
    // Dependency: Day Selection
    private let dayVM: DayViewModel
    
    // Exercise Entry Use Case
    private let entryUseCases: ExerciseEntryUseCasesProtocol
    
    // MARK: Init
    init(dayVM: DayViewModel, entryUseCases: ExerciseEntryUseCasesProtocol) {
        self.dayVM = dayVM
        self.entryUseCases = entryUseCases
    }
    
    // MARK: Methods
    func fetchAllEntries() async {
        guard let day = dayVM.selectedDay else {
            status = .error(error: "Error with day fetching all Exercise Entries")
            return
        }
        status = .loading
        do {
            entries = try await entryUseCases.fetchAllEntries(for: day)
            selectedEntry = entries.first
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func fetchEntry(by id: UUID) async {
        status = .loading
        do {
            entry = try await entryUseCases.fetchEntry(by: id)
            selectedEntry = entry
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func addEntry(_ entry: ExerciseEntry) async {
        guard let day = dayVM.selectedDay else {
            status = .error(error: "Error with day fetching adding an Exercise Entry")
            return
        }
        status = .loading
        do {
            try await entryUseCases.createEntry(entry, to: day)
            selectedEntry = entry
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteEntry(_ entry: ExerciseEntry? = nil) async {
        let entryToDelete = entry ?? selectedEntry
        guard let entryToDelete else {
            status = .error(error: "No entry selected to delete")
                        return
        }
        status = .loading
        do {
            try await entryUseCases.deleteEntry(entryToDelete)
            await fetchAllEntries() // Refresh
            // If you are currentrly selecting the exercise entry you are deleting, then it will select the first entry it finds after deletion
            if selectedEntry?.id == entryToDelete.id {
                selectedEntry = entries.first
            }
            status = .loaded
        }catch {
            status = .error(error: error.localizedDescription)
        }
    }
}
