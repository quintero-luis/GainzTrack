//
//  EditSetsView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

import SwiftUI

struct EditSetsView: View {
    @State var entry: ExerciseEntry
    @ObservedObject var setVM: ExerciseSetViewModel

    @State private var weight: Double = 0
    @State private var reps: Int = 0
    @State private var weightUnit = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Edit Sets for \(entry.exercise?.name ?? "Exercise")")
                    .font(.headline)

                // List current sets
                List(entry.sets, id: \.id) { set in
                    HStack {
                        //\(entry.exercise.weightUnit.rawValue)
                        Text("Weight: \(set.weight, specifier: "%.2f") ")
                        Spacer()
                        Text("Reps: \(set.reps)")
                    }
                }

                Divider()

                // Add new set
                VStack(spacing: 8) {
                    Text("Add New Set")
                        .font(.subheadline)
                    HStack {
                        Text("Weight")
                        TextField("Weight", value: $weight, format: .number)
                            .frame(width: 70)
                            .textFieldStyle(.roundedBorder)
//                        Text(entry.exercise.weightUnit.rawValue)
                    }
                    HStack {
                        Text("Reps")
                        TextField("Reps", value: $reps, format: .number)
                            .frame(width: 70)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Text("Weight Unit")
                        TextField("Weight Unit", text: $weightUnit)
                            .frame(width: 70)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Add Set") {
                        let newSet = ExerciseSet(
                            weight: weight,
                            reps: reps,
                            entry: entry
                        )
                        Task {
                            await setVM.addSet(newSet)
                            await setVM.fetchAllSets()
                            // Optionally, update entry.sets locally if needed
                            entry.sets.append(newSet)
                            
                        }
                        weight = 0
                        reps = 0
                    }
                    .padding(.top)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Edit Sets")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        // Dismiss logic (parent Sheet)
                    }
                }
            }
            .onAppear {
                Task { await setVM.fetchAllSets() }
            }
        } // NavigationView
        .onAppear {
            print("Navegaste a EditSetsView para el ejercicio: \(entry.exercise?.name ?? "sin nombre")")
        }
    }
}

/*
 Button(exercise.name) { selectedExercise = exercise }
 .foregroundColor(selectedExercise?.id == exercise.id ? .blue : .primary) // Makes textColor blue to selected exercise cell
 
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
 */
