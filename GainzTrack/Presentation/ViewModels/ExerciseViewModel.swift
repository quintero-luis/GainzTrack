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
    
    // Dependency: MuscleGroup selection
    private let muscleGroupVM: MuscleGroupViewModel
    
    // MARK: Exercise VM Use Cases
    private let exerciseUseCases: ExerciseUseCasesProtocol
    
    // MARK: Exercise VM Init
    init(
            muscleGroupVM: MuscleGroupViewModel,
            exerciseUseCases: ExerciseUseCasesProtocol
        ) {
            self.muscleGroupVM = muscleGroupVM
            self.exerciseUseCases = exerciseUseCases
        }
    
    // MARK: Exercise VM Methods
    func fetchAllExercises() async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else { return }
        status = .loading
        do {
            exercises = try await exerciseUseCases.fetchAllExercises(for: muscleGroup)
            selectedExercise = exercise
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func fetchExercise(by id: UUID) async {
        status = .loading
        do {
            exercise = try await exerciseUseCases.fetchExercise(by: id)
            selectedExercise = exercise // Update selected exercise
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
            try await exerciseUseCases.createExercise(exercise, to: muscleGroup)
            await fetchAllExercises() // Refresh after adding exercise
            // TODO: Check usability in UI test
            selectedExercise = exercise // Make the newly added one selected
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func updateExercise(_ exercise: Exercise) async {
        guard let muscleGroup = muscleGroupVM.selectedMuscleGroup else {
            status = .error(error: "No muscle group selected updating Exercise")
            return
        }
        status = .loading
        do {
            try await exerciseUseCases.updateExercise(exercise) // Use selectedExercise?
            await fetchAllExercises()
            selectedExercise = exercise
            status = .loaded
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
    
    func  deleteExercise(_ exercise: Exercise? = nil) async {
        // Use exercise if not nil; if exercise is nil, use selectedExercise
        guard let exerciseToDelete = exercise ?? selectedExercise else {
                status = .error(error: "No exercise selected to delete")
                return
            }
        
        status = .loading
        do {
            try await exerciseUseCases.deleteExercise(exerciseToDelete)
            await fetchAllExercises()
            
            // if -> used to DEselect deleted object, and select the first object from the list
            if selectedExercise?.id == exerciseToDelete.id {
                selectedExercise = exercises.first
            }
            
        } catch {
            status = .error(error: error.localizedDescription)
        }
    }
}
