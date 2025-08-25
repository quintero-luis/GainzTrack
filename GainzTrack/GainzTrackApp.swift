//
//  GainzTrackApp.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

import SwiftUI
import SwiftData

@main
struct GainzTrackApp: App {
    
    let container: ModelContainer

        init() {
            container = try! ModelContainer(
                for: Day.self, Exercise.self, ExerciseEntry.self, ExerciseSet.self, MuscleGroup.self
            )
        }
    
    var body: some Scene {
        WindowGroup {
            TodayView()
                .modelContainer(container)
        }
    }
}
