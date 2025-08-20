//
//  GetDayByDateUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

// MARK: - Protocol
protocol GetDayByDateUseCaseProtocol {
    func execute(date: Date) async throws -> Day?
}

// MARK: - Implementation
final class GetDayByDateUseCase: GetDayByDateUseCaseProtocol {
    private let repository: DayRepositoryProtocol
    
    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(date: Date) async throws -> Day? {
        return try await repository.getDay(by: date)
    }
}
