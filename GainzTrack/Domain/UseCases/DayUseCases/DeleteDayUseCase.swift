//
//  DeleteDayUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol DeleteDayUseCaseProtocol {
    func execute(_ day: Day) async throws
}

final class DeleteDayUseCase: DeleteDayUseCaseProtocol{
    private let repository: DayRepositoryProtocol
    
    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }
    func execute(_ day: Day) async throws {
        return try await repository.deleteDay(day)
    }
}
