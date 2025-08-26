//
//  GainzTrackApp.swift
//  GainzTrack
//
//  Created by Luis Quintero on 19/08/25.
//

//import SwiftUI
//import SwiftData
//
//@main
//struct GainzTrackApp: App {
//    let container: ModelContainer
//
//        init() {
//            container = try! ModelContainer(
//                for: Day.self, Exercise.self, ExerciseEntry.self, ExerciseSet.self, MuscleGroup.self
//            )
//        }
//    
//    var body: some Scene {
//        WindowGroup {
//            TodayView()
//                .modelContainer(container)
//        }
//    }
//}


import SwiftUI
import SwiftData

@main
struct GainzTrackApp: App {
    let container: ModelContainer

    init() {
        container = try! ModelContainer(
            for: Day.self,
            Exercise.self,
            ExerciseEntry.self,
            ExerciseSet.self,
            MuscleGroup.self
        )
    }

    var body: some Scene {
        WindowGroup {
            // MARK: - Repositories
            let dayRepository = DayRepository(context: container.mainContext)
            let muscleGroupRepo = MuscleGroupRepository(context: container.mainContext)
            let entryRepo = ExerciseEntryRepository(context: container.mainContext)
            let exerciseRepo = ExerciseRepository(context: container.mainContext)

            // MARK: - UseCases
            let dayUseCases = DayUseCases(repository: dayRepository)
            let muscleGroupUseCases = MuscleGroupUseCases(repository: muscleGroupRepo)
            let entryUseCases = ExerciseEntryUseCases(repository: entryRepo)
            let exerciseUseCases = ExerciseUseCases(repository: exerciseRepo)

            // MARK: - ViewModels
            let dayVM = DayViewModel(dayUseCases: dayUseCases)
            let muscleGroupVM = MuscleGroupViewModel(muscleGroupUseCases: muscleGroupUseCases)
            let entryVM = ExerciseEntryViewModel(dayVM: dayVM, entryUseCases: entryUseCases)
            let exerciseVM = ExerciseViewModel(muscleGroupVM: muscleGroupVM, exerciseUseCases: exerciseUseCases)

            // MARK: - Root View
            TodayView(
                dayVM: dayVM,
                entryVM: entryVM,
                muscleGroupVM: muscleGroupVM,
                exerciseVM: exerciseVM
            )
            .modelContainer(container)
        }
    }
}

//import SwiftUI
//import SwiftData
//
//@main
//struct GainzTrackApp: App {
//    let container: ModelContainer
//
//    init() {
//        container = try! ModelContainer(
//            for: Day.self, Exercise.self, ExerciseEntry.self, ExerciseSet.self, MuscleGroup.self
//        )
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            // Inicializar los ViewModels con mocks de UseCases o con UseCases reales
//            let dayVM = DayViewModel(dayUseCases: DayUseCases(context: container))
//            let muscleGroupVM = MuscleGroupViewModel(muscleGroupUseCases: RealMuscleGroupUseCases(context: container))
//            let entryVM = ExerciseEntryViewModel(dayVM: dayVM, entryUseCases: RealExerciseEntryUseCases(context: container))
//
//            TodayView(
//                dayVM: dayVM,
//                entryVM: entryVM,
//                muscleGroupVM: muscleGroupVM
//            )
//            .modelContainer(container)
//        }
//    }
//}

