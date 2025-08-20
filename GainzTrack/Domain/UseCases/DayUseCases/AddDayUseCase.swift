//
//  AddDayUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

protocol AddDayUseCaseProtocol {
    func execute(_ day: Day) async throws
}

final class AddDayUseCase: AddDayUseCaseProtocol {
    private let repository: DayRepositoryProtocol
    
    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ day: Day) async throws {
        return try await repository.addDay(day)
    }
}
