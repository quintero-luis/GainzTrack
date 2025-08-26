//
//  MuscleGroupPickerView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

import SwiftUI

struct MuscleGroupPickerView: View {
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    @ObservedObject var entryVM: ExerciseEntryViewModel

    // Selección de exercise en la UI
    @State private var selectedExercise: Exercise?

    var body: some View {
        NavigationStack {
            VStack {
                // MuscleGroup List
                List(muscleGroupVM.muscleGroups, id: \.id) { mg in
                    Button(mg.name) {
                        muscleGroupVM.selectedMuscleGroup = mg
                    }
                }
                .listStyle(.plain)

                // Exercise list of the selected mucle group
                if let mg = muscleGroupVM.selectedMuscleGroup {
                    Text("Exercises in \(mg.name)")
                        .font(.headline)
                        .padding(.top)
                    // If the selected MuscleGroup has not exercises Yet
                    if mg.exercises.isEmpty {
                        NavigationLink {
                            AddExerciseView(muscleGroup: mg)
                        } label: {
                            Label("Add exercise", systemImage: "plus.circle")
                        }
                    } else {
                        List(mg.exercises, id: \.id) { exercise in
                            Button(exercise.name) { selectedExercise = exercise }
                                .foregroundColor(selectedExercise?.id == exercise.id ? .blue : .primary)
                        }
                    }
                    
                }

                // Button to add an ExerciseEntry to the current day
                if let exercise = selectedExercise {
                    Button("Add \(exercise.name) to Today") {
                        Task {
                            guard let day = entryVM.dayVM.selectedDay else { return }
                            let entry = ExerciseEntry(day: day, exercise: exercise)
                            await entryVM.addEntry(entry)
                        }
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            } // VStack
            .navigationTitle("Select Muscle Group")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        
                            NavigationLink {
                                // MARK: - Navigate to AddMuscleGroup
                                AddMuscleGroupView(muscleGroupVM: muscleGroupVM, exerciseVM: exerciseVM)
                            } label: {
                                Label("MuscleGroup add", systemImage: "plus.circle")
                            }
                    }
                }
            }
            // Cargar muscleGroups al aparecer
            .task {
                await muscleGroupVM.fetchAllMuscleGroups()
            }
        }
    }
} // Muscle Group Picker




// MARK: - Crear Exercise
struct AddExerciseView: View {
    var muscleGroup: MuscleGroup
    @State private var name: String = ""

    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $name)
                Button("Save") {
                    let exercise = Exercise(name: name)
                    exercise.muscleGroup = muscleGroup
                    context.insert(exercise)
                }
            }
            .navigationTitle("New Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    
                }
            }
        }
    }
}

