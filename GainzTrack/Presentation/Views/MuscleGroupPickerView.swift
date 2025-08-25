//
//  MuscleGroupPickerView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

//import SwiftUI
//
//struct MuscleGroupPickerView: View {
//    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
//    @ObservedObject var exerciseVM: ExerciseViewModel
//    @ObservedObject var entryVM: ExerciseEntryViewModel
//    @ObservedObject var dayVM: DayViewModel
//
//    @State private var selectedMuscleGroup: MuscleGroup?
//    @State private var selectedExercise: Exercise?
//    @State private var showAddExerciseSheet = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Select Muscle Group")
//                    .font(.headline)
//                List(muscleGroupVM.muscleGroups, id: \.id) { muscleGroup in
//                    Button(action: {
//                        selectedMuscleGroup = muscleGroup
//                        muscleGroupVM.selectedMuscleGroup = muscleGroup
//                        Task {
//                            await exerciseVM.fetchAllExercises()
//                        }
//                    }) {
//                        Text(muscleGroup.name)
//                            .foregroundColor(.primary)
//                    }
//                }
//                .listStyle(.plain)
//
//                if let selectedMuscleGroup {
//                    Text("Exercises in \(selectedMuscleGroup.name)")
//                        .font(.headline)
//                    List(exerciseVM.exercises, id: \.id) { exercise in
//                        Button(action: {
//                            selectedExercise = exercise
//                        }) {
//                            Text(exercise.name)
//                                .foregroundColor(.primary)
//                        }
//                    }
//                }
//
//                if let muscleGroup = selectedMuscleGroup, let exercise = selectedExercise {
//                    Button("Add to Today") {
//                        let entry = ExerciseEntry(
//                            day: dayVM.selectedDay?.id,
//                            exercise: exercise)
//                        Task {
//                            await entryVM.addEntry(entry)
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .navigationTitle("Add Exercise")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Close") {
//                        // Dismiss logic (parent Sheet)
//                    }
//                }
//            }
//            .onAppear {
//                Task { await muscleGroupVM.fetchAllMuscleGroups() }
//            }
//        }
//    }
//}

//ExerciseEntry(
//    id: UUID(),
//    exercise: exercise,
//    sets: [],
//    dayId: dayVM.selectedDay?.id ?? UUID() // fallback if no day selected
//)
