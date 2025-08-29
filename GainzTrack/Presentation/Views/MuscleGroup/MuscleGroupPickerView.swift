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
    @ObservedObject var setVM: ExerciseSetViewModel
    
    let today: Day

    @State private var selectedExercise: Exercise?

    var body: some View {
        NavigationStack {
            VStack {
                // MuscleGroup List after home
                List(muscleGroupVM.muscleGroups, id: \.id) { mg in
                    NavigationLink {
                        // TODO: Navigate to another window showcasing the exercise list of the selected muscleGroup
                        ExerciseListView(
                            musclegroupVM: muscleGroupVM,
                            exerciseVM: exerciseVM, entryVM: entryVM, setVM: setVM,
                            today: today,
                            selectedMuscleGroup: mg // pass selectedMuscleGroup to see its exercises list
                        )
                    } label: {
                        Text(mg.name)
                    }
                }
                .listStyle(.plain)

                // Exercise list of the selected mucle group
                if let mg = muscleGroupVM.selectedMuscleGroup {
                    Text("\(mg.name) exercises ")
                        .font(.headline)
                        .padding(.top)
                    // If the selected MuscleGroup has not exercises Yet
                    if mg.exercises.isEmpty {
                        NavigationLink {
//                            AddExerciseView(muscleGroup: mg)
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
//                if let exercise = selectedExercise {
//                    Button("Add \(exercise.name) to Today") {
//                        
//                    }
//                    .padding(.bottom, 44)
//                    .buttonStyle(.plain)
//                }
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


#Preview {
    let dayVM = DayViewModel(dayUseCases: DayUseCasesMock())
    
    let muscleGroupVM = MuscleGroupViewModel(
        muscleGroupUseCases: MuscleGroupUseCaseMock()
    )
    
    let exerciseVM = ExerciseViewModel(
        muscleGroupVM: muscleGroupVM,
        exerciseUseCases: ExerciseUseCaseMock()
    )
    
    let entryVM = ExerciseEntryViewModel(
        dayVM: dayVM,
        entryUseCases: ExerciseEntryUseCasesMock()
    )
    
    let setVM = ExerciseSetViewModel(
        entryMV: entryVM,
        setUseCases: ExerciseSetUseCasesMock())

    let mockToday = Day(date: Date()) // Día de prueba

    MuscleGroupPickerView(
        muscleGroupVM: muscleGroupVM,
        exerciseVM: exerciseVM,
        entryVM: entryVM,
        setVM: setVM,
        today: mockToday
    )
}
// Preview







