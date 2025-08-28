//
//  AddExerciseView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 26/08/25.
//

import SwiftUI
// MARK: - Create Exercise
struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss // To go back to the last view after saving
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    
    var selectedMuscleGroup: MuscleGroup?
    
    @State private var exerciseName: String = ""
    // Alert after creating an Exercise
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $exerciseName)
                Button("Save") {
                    guard !exerciseName.isEmpty, let mg = selectedMuscleGroup else {
                        exerciseVM.status = .error(error: "Error adding exercise")
                        return
                    }
                    
                    Task {
                        let exerciseToAdd = Exercise(name: exerciseName)
                        exerciseToAdd.muscleGroup = mg
                        mg.exercises.append(exerciseToAdd)
                        await exerciseVM.addExercise(exerciseToAdd)
                        exerciseName = "" // Empty exercise name field after adding one
                        dismiss()
                    }
                }
                .disabled(exerciseName.isEmpty)
                Button("Cancel", role: .cancel) {
                    exerciseName = "" // Resets field to empty
                }
                // TODO: Alert showing exercise succesfully created
                
            }
            .navigationTitle("New Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    
                }
            }
        }
    }
}
