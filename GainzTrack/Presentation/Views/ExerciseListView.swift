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
                            NavigationLink {
                                // Todo navigation to ExerciseSet for selected Exercise
                            } label: {
                                Text(exercise.name)
                            }
                        }
                    } // else
                }
                
                VStack { // VStack Floating Button
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

