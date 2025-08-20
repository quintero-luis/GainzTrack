//
//  UpdateDayUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol UpdateDayUseCaseProtocol {
    func execute(_ day: Day) async throws
}

final class UpdateDayUseCase: UpdateDayUseCaseProtocol {
    private let repository: DayRepositoryProtocol
    
    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ day: Day) async throws {
        return try await repository.updateDay(day)
    }
}
