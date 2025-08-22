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
    // Crear el ModelContext de SwiftData
    @Environment(\.modelContext) private var modelContext

    var body: some Scene {
        WindowGroup {
            let dayRepository = DayRepository(context: modelContext)
            let muscleGroupRepository = MuscleGroupRepository(context: modelContext)
            let exerciseRepository = ExerciseRepository(context: modelContext)
            
            // UseCases para Day
            let getAllDaysUseCase = GetAllDaysUseCase(repository: dayRepository)
            let getDayByDateUseCase = GetDayByDateUseCase(repository: dayRepository)
            let addDayUseCase = AddDayUseCase(repository: dayRepository)
            let updateDayUseCase = UpdateDayUseCase(repository: dayRepository)
            let deleteDayUseCase = DeleteDayUseCase(repository: dayRepository)
            
            // UseCases para MuscleGroup
            let getAllMuscleGroupsUseCase = GetAllMuscleGroupsUseCase(repository: muscleGroupRepository)
            let getMuscleGroupUseCase = GetMuscleGroupUseCase(repository: muscleGroupRepository)
            let addMuscleGroupUseCase = AddMuscleGroupUseCase(repository: muscleGroupRepository)
            let updateMuscleGroupUseCase = UpdateMuscleGroupUseCase(repository: muscleGroupRepository)
            let deleteMuscleGroupUseCase = DeleteMuscleGroupUseCase(repository: muscleGroupRepository)
            
            // UseCases para Exercise
            let getAllExercisesUseCase = GetAllExercisesUseCase(repository: exerciseRepository)
            let getExerciseUseCase = GetExerciseUseCase(repository: exerciseRepository)
            let addExerciseUseCase = AddExersiceUseCase(repository: exerciseRepository)
            let updateExerciseUseCase = UpdateExerciseUseCase(repository: exerciseRepository)
            let deleteExerciseUseCase = DeleteExerciseUseCase(repository: exerciseRepository)
            
            // ViewModels
            let dayVM = DayViewModel(
                getAllDaysUseCase: getAllDaysUseCase,
                getDayByDateUseCase: getDayByDateUseCase,
                addDayUseCase: addDayUseCase,
                updateDayUseCase: updateDayUseCase,
                deleteDayUseCase: deleteDayUseCase
            )
            
            let muscleGroupVM = MuscleGroupViewModel(
                addMuscleGroupUseCase: addMuscleGroupUseCase,
                deleteMuscleGroupUseCase: deleteMuscleGroupUseCase,
                getAllMuscleGroupsUseCase: getAllMuscleGroupsUseCase,
                getMuscleGroupUseCase: getMuscleGroupUseCase,
                updateMuscleGroupUseCase: updateMuscleGroupUseCase,
                daysVM: dayVM
            )
            
            let exerciseVM = ExerciseViewModel(
                muscleGroupVM: muscleGroupVM,
                addExerciseUseCase: addExerciseUseCase,
                deleteExerciseUseCase: deleteExerciseUseCase,
                getAllExercisesUseCase: getAllExercisesUseCase,
                getExerciseUseCase: getExerciseUseCase,
                updateExerciseUseCase: updateExerciseUseCase
            )
            
            // Vista principal
            DayView(dayVM: dayVM, exerciseVM: exerciseVM, muscleGroupVM: muscleGroupVM)
        }
    }
}

