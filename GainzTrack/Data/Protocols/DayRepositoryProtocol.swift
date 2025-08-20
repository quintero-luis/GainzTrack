//
//  DayRepositoryProtocol.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation

// async throws because SwiftData uses asynchronous operations and can throw errors.
protocol DayRepositoryProtocol {
    func getAllDays() async throws -> [Day]
    func getDay(by date: Date) async throws -> Day?
    func addDay(_ day: Day) async throws
    func updateDay(_ day: Day) async throws
    func deleteDay(_ day: Day) async throws
}
