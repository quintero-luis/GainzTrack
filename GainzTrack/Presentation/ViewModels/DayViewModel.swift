//
//  DayViewModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation
import SwiftData

@MainActor
final class DayViewModel: ObservableObject {
    // MARK: Published properties
    @Published var days: [Day] = []
    @Published var selectedDay: Day? // Important for horizontal navigation between days
    @Published var status: Status = .none
    
    // MARK: ModelContext
        var context: ModelContext? = nil
    
    // MARK: UseCases for DayVM
    private let getAllDaysUseCase: GetAllDaysUseCase
    private let getDayByDateUseCase: GetDayByDateUseCase
    private let addDayUseCase: AddDayUseCase
    private let updateDayUseCase: UpdateDayUseCase
    private let deleteDayUseCase: DeleteDayUseCase
    
    // MARK: - Init
    init(
        getAllDaysUseCase: GetAllDaysUseCase,
        getDayByDateUseCase: GetDayByDateUseCase,
        addDayUseCase: AddDayUseCase,
        updateDayUseCase: UpdateDayUseCase,
        deleteDayUseCase: DeleteDayUseCase
    ) {
        self.getAllDaysUseCase = getAllDaysUseCase
        self.getDayByDateUseCase = getDayByDateUseCase
        self.addDayUseCase = addDayUseCase
        self.updateDayUseCase = updateDayUseCase
        self.deleteDayUseCase = deleteDayUseCase
    }
    
    // MARK: Set ModelContext
        func setContext(_ context: ModelContext) {
            self.context = context
        }
    
    // MARK: Methods
    func fetchAllDays() async {
        guard context != nil else {
                    status = .error(error: "ModelContext not set")
                    return
                }
        await MainActor.run { self.status = .loading }
        do {
            let result = try await getAllDaysUseCase.execute()
            await MainActor.run {
                self.days = result
                self.selectedDay = result.first
                self.status = .loaded
            }
        } catch {
            await MainActor.run {
                        self.status = .error(error: error.localizedDescription)
                    }
        }
    }
    
    func fetchDay(by date: Date) async {
        guard context != nil else {
                    status = .error(error: "ModelContext not set")
                    return
                }
        status = .loading
        do {
            selectedDay = try await getDayByDateUseCase.execute(date: date)
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func addDay(_ day: Day) async {
        guard context != nil else {
                    status = .error(error: "ModelContext not set")
                    return
                }
        status = .loading
        do {
            try await addDayUseCase.execute(day)
            await fetchAllDays() // Refresh list
            selectedDay = day
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateDay(_ day: Day) async {
        guard context != nil else {
                    status = .error(error: "ModelContext not set")
                    return
                }
        status = .loading
        do {
            try await updateDayUseCase.execute(day)
            await fetchAllDays() // Refresh list
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func deleteDay(_ day: Day) async {
        guard context != nil else {
                    status = .error(error: "ModelContext not set")
                    return
                }
        status = .loading
        do {
            try await deleteDayUseCase.execute(day)
            await fetchAllDays() // Refresh list
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    // MARK: Navigation helpers (horizontal scrolling)
    func selectNextDay() {
        guard !days.isEmpty, let current = selectedDay, /// Check that a day is currently selected
              /// Search the days list for the position of the currently selected day.
                // Circular navigation.
                let index = days.firstIndex(of: current) else {
            status = .error(error: "day is Not empty or No day currently selected trying to select next day")
            return
        } // TODO: Improve else?
        let nextIndex = (index + 1) % days.count /// Monday=0, Tuesday=1, Wednesday=2 ( Currentrly at Tuesday)
        selectedDay = days[nextIndex]            /// (1+1)%3 = 2 ->  wednesday  next -> (2+1)%3 = 0 -> Monday
    }
    
    func selectPreviousDay() {
        guard !days.isEmpty, let current = selectedDay, // Check that a day is currently selected
              let index = days.firstIndex(of: current) else {
            status = .error(error: "day is Not empty or No day currently selected trying to select previous day")
            return
        }
        let prevIndex = (index - 1 + days.count) % days.count
        selectedDay = days[prevIndex]
    }
}
