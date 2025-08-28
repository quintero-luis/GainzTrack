//
//  ExerciseListView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 26/08/25.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var musclegroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    @ObservedObject var entryVM: ExerciseEntryViewModel // To add Exercise as ExerciseEntry to Today
    
    var selectedMuscleGroup: MuscleGroup // Muscle Group passed from MuscleGroupPickerView
    
    @State private var selectedExercise: Exercise?
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6) // Set all view to gray
                    .ignoresSafeArea()
                VStack {
                    Text(selectedMuscleGroup.name)
                    Spacer()
                    if selectedMuscleGroup.exercises.isEmpty {
                        Text("This muscleGroup has no exercises yet")
                            .foregroundColor(.gray)
                    } else {
                        List(selectedMuscleGroup.exercises, id: \.id) { exercise in
//                            NavigationLink {
//                                // Todo navigation to ExerciseSet for selected Exercise
//                            } label: {
//                                Text(exercise.name)
//                            }
                            Button(exercise.name) { selectedExercise = exercise }
                            .foregroundColor(selectedExercise?.id == exercise.id ? .blue : .primary) // Makes textColor blue to selected exercise cell
                        }
                    } // else
                    
                    if let exercise = selectedExercise {
                        Button("Add \(exercise.name) to Today ") {
                            Task {
                                guard let day = entryVM.dayVM.selectedDay else {
                                    return // TODO: Handle error
                                }
                                //TODO: Make bidirectional like in AddExerciseView
                                let entry = ExerciseEntry(day: day, exercise: exercise)
                                exercise.entries.append(entry)
                                await entryVM.addEntry(entry)
                            }
                        }
                    }
                    
                } // VStack
                
                
                
                // MARK: VStack Floating Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // MARK: PLUS Button to add exercise to the selected muscle group
                        NavigationLink {
                            AddExerciseView(
                                muscleGroupVM: musclegroupVM,
                                exerciseVM: exerciseVM,
                                selectedMuscleGroup: selectedMuscleGroup
                            )
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 32))
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4, x: 0, y: 2)
                        }
                        .padding()
                    }
                } // VStack Floating Button

            }
        } // Navigation Stack
        .task {
            await exerciseVM.fetchAllExercises()
        }
    }
}

