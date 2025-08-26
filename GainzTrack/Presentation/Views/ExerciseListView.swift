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
            Spacer()
            HStack {
                Spacer()
                
                // Button to add exercise to the selected muscle group
                NavigationLink {
                    AddExerciseView(muscleGroupVM: musclegroupVM, exerciseVM: exerciseVM, selectedMuscleGroup: selectedMuscleGroup)
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
        } // Navigation Stack
    }
}

