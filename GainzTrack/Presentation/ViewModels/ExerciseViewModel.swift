//
//  ExerciseViewModel.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import Foundation


@MainActor
final class ExerciseViewModel: ObservableObject {
    // MARK: Exercise VM Published properties
    @Published var exercises: [Exercise] = []
    @Published var exercise: Exercise?
    @Published var selectedExercise: Exercise?
    
    @Published var status: Status = .none
    
    private let muscleGroupVM: MuscleGroupViewModel
    
    // MARK: Exercise VM Use Cases
    private let addExerciseUseCase: AddExersiceUseCase
    private let deleteExerciseUseCase: DeleteExerciseUseCase
    private let getAllExercisesUseCase: GetAllExercisesUseCase
    private let getExerciseUseCase: GetExerciseUseCase
    private let updateExerciseUseCase: UpdateExerciseUseCase
    
    // MARK: Exercise VM Init
    init(muscleGroupVM: MuscleGroupViewModel,
         addExerciseUseCase: AddExersiceUseCase,
         deleteExerciseUseCase: DeleteExerciseUseCase,
         getAllExercisesUseCase: GetAllExercisesUseCase,
         getExerciseUseCase: GetExerciseUseCase,
         updateExerciseUseCase: UpdateExerciseUseCase
    ) {
        self.muscleGroupVM = muscleGroupVM
        self.addExerciseUseCase = addExerciseUseCase
        self.deleteExerciseUseCase = deleteExerciseUseCase
        self.getAllExercisesUseCase = getAllExercisesUseCase
        self.getExerciseUseCase = getExerciseUseCase
        self.updateExerciseUseCase = updateExerciseUseCase
    }
    
    // MARK: Exercise VM Methods
    func fetchAllExercises() async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else { return }
        status = .loading
        do {
            exercises = try await getAllExercisesUseCase.execute(for: muscleGroup)
            selectedExercise = exercises.first
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func fetchExercise(by id: UUID) async {
        status = .loading
        do {
            exercise = try await getExerciseUseCase.execute(by: id)
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    // TODO: We need to put something inside ()?
    func addExercise(_ exercise: Exercise) async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else {
            status = .error(error: "No muscle group selected adding Exercise")
            return
        }
        status = .loading
        do {
            try await addExerciseUseCase.execute(exercise, to: muscleGroup)
            await fetchAllExercises() // Refresh after adding exercise
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateExercise(_ exercise: Exercise) async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else {
            status = .error(error: "No muscle group selected adding Exercise")
            return
        }
        status = .loading
        do {
            try await updateExerciseUseCase.execute(exercise: exercise) // Use selectedExercise?
            await fetchAllExercises()
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func  deleteExercise(_ exercise: Exercise) async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else {
            status = .error(error: "No muscle group selected adding Exercise")
            return
        }
        status = .loading
        do {
            try await deleteExerciseUseCase.execute(exercise)
            await fetchAllExercises()
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
}
