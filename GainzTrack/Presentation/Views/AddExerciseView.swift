//
//  AddExerciseView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 26/08/25.
//

import SwiftUI
// MARK: - Create Exercise
struct AddExerciseView: View {
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    
    var selectedMuscleGroup: MuscleGroup
    
    @State private var exerciseName: String = ""
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $exerciseName)
                Button("Save") {
                    guard !exerciseName.isEmpty, let mg = muscleGroup else {
                        exerciseVM.status = .error(error: "Error adding exercise")
                        return
                    }
                    let exercise = Exercise(name: exerciseName)
                    exercise.muscleGroup = selectedMuscleGroup
                    (exercise)
                }
                .disabled(name.isEmpty)
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
