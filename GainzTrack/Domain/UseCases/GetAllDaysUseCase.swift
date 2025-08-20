//
//  GetAllDaysUseCase.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

// MARK: Protocol
protocol GetAllDaysUseCaseProtocol {
    func execute() async throws -> [Day]
}


final class GetAllDaysUseCase: GetAllDaysUseCaseProtocol {
    private let repository: DayRepositoryProtocol
    
    init(repository: DayRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Day] {
        return try await repository.getAllDays()
    }
}
