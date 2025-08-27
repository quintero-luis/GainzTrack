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
    // Alert after creating an Exerciseç
    @State private var showAlert = false
    @State private var alertMessage = ""
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $exerciseName)
                Button("Save") {
                    guard !exerciseName.isEmpty else {
                        exerciseVM.status = .error(error: "Error adding exercise")
                        return
                    }
                    
                    Task {
                        let exerciseToAdd = Exercise(name: exerciseName)
                        exerciseToAdd.muscleGroup = selectedMuscleGroup
                        await exerciseVM.addExercise(exerciseToAdd)
                        exerciseName = "" // Empty exercise name field after adding one
                    }
                    showAlert = true
                }
                .disabled(exerciseName.isEmpty)
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Si"))
//                }
                
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
