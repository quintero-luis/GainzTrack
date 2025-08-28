//
//  AddDayUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol DayUseCasesProtocol {
    func fetchAllDays() async throws -> [Day]
    func fetchDay(by date: Date) async throws -> Day?
    func createDay(_ day: Day) async throws
    func updateDay(_ day: Day) async throws
    func deleteDay(_ day: Day) async throws
    func getOrCreateToday() async throws -> Day
}

final class DayUseCases: DayUseCasesProtocol {
    private let repository: DayRepositoryProtocol

    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAllDays() async throws -> [Day] {
        try await repository.getAllDays()
    }

    func fetchDay(by date: Date) async throws -> Day? {
        try await repository.getDay(by: date)
    }

    func createDay(_ day: Day) async throws {
        try await repository.addDay(day)
    }

    func updateDay(_ day: Day) async throws {
        try await repository.updateDay(day)
    }

    func deleteDay(_ day: Day) async throws {
        try await repository.deleteDay(day)
    }
    
    func getOrCreateToday() async throws -> Day {
        try await repository.getOrCreateToday()
    }
}


