//
//  AddMuscleGroupView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 26/08/25.
//

import SwiftUI
import SwiftData

struct AddMuscleGroupView: View {
    @Environment(\.dismiss) private var dismiss // To go back to the last view after saving
    
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    
    @State private var exerciseName: String = ""
    @State private var newMuscleGroupName: String = ""
    @State private var selectedMuscleGroup: MuscleGroup? = nil
    @State private var showAddItemAlert = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Add Exercise") {
                    TextField("Exercise Name", text: $exerciseName)
                    Button("Save") {
                        guard !exerciseName.isEmpty, let mg = selectedMuscleGroup else {
                            exerciseVM.status = .error(error: "exercise name is not empty")
                            return
                        }
                        Task {
                            let exerciseToAdd = Exercise(name: exerciseName)
                            exerciseToAdd.muscleGroup = mg
                            mg.exercises.append(exerciseToAdd)
                            await exerciseVM.addExercise(exerciseToAdd)
                            exerciseName = "" // Reset Fields afer saving
                            selectedMuscleGroup = nil // Reset Fields afer saving
                            dismiss()
                        }
                    }
                    .disabled(exerciseName.isEmpty || selectedMuscleGroup == nil) // Disable button save while condition is not met
                    // TODO: Alert showing exercise succesfully created
                } // 1 Add Exercise Section
                Section("Select Muscle Group") {
                    HStack {
                        Picker(selection: $selectedMuscleGroup) {
                            Text("None").tag(MuscleGroup?.none) // Tag the placeholder option as nil
                            
                            ForEach(muscleGroupVM.muscleGroups, id: \.id) { mg in
                                Text(mg.name).tag(Optional(mg)) // Tag the picker option with the muscle group
                            }
                        } label: {
                            Text(selectedMuscleGroup?.name ?? "")
                        }// Picker
                        .pickerStyle(.automatic)
                        
                        Spacer()
                        
                        Button {
                            showAddItemAlert = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                        .alert("New Item", isPresented: $showAddItemAlert, actions: {
                            TextField("Item name", text: $newMuscleGroupName)
                            
                            Button("Add") {
                                if !newMuscleGroupName.isEmpty {
                                    let mgToAdd = MuscleGroup(name: newMuscleGroupName)
                                    Task {
                                        await muscleGroupVM.addMuscleGroup(mgToAdd)
                                        selectedMuscleGroup = mgToAdd
                                        newMuscleGroupName = ""
                                    }
                                    
                                }
                            }
                            .disabled(newMuscleGroupName.isEmpty) // If field is empty, Add button is disabled
                            
                            Button("Cancel", role: .cancel) {
                                newMuscleGroupName = "" // Resets field to empty
                            }
                        })
                        // TODO: Alert showing muscle group succesfully created
                    } // HStack
                } // 2 Muscle Group Section and addition
            } // Form
            .navigationTitle("New Exercise")
        } // Navigation Stack
    } // View
} // Struct

