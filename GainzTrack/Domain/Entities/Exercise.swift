//
//  ExcerciseModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import Foundation
import SwiftData

import Foundation
import SwiftData

@Model
final class Exercise: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var sets: [ExerciseSet] = [] // Relación a múltiples ExerciseSet
    
    init(name: String) {
        self.name = name
    }
}

@Model
final class ExerciseSet: Sendable {
    @Attribute(.unique) var id: UUID = UUID()
    var weight: Double
    var reps: Int
    
    init(weight: Double, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
}


//import Foundation
//import SwiftData
//
//@Model
//final class Exercise: Sendable {
//    @Attribute(.unique) var id: UUID = UUID()
//    var name: String
//    var reps: Int
//    var weight: Double
//    
//    init(name: String, reps: Int, weight: Double) {
//        self.name = name
//        self.reps = reps
//        self.weight = weight
//    }
//}

