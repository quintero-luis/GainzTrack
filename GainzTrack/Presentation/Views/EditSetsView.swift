//
//  EditSetsView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

//import SwiftUI
//
//struct EditSetsView: View {
//    @State var entry: ExerciseEntry
//    @ObservedObject var setVM: ExerciseSetViewModel
//
//    @State private var weight: Double = 0
//    @State private var reps: Int = 0
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Edit Sets for \(String(describing: entry.exercise?.name))")
//                    .font(.headline)
//
//                // List current sets
//                List(entry.sets, id: \.id) { set in
//                    HStack {
//                        //\(entry.exercise.weightUnit.rawValue)
//                        Text("Weight: \(set.weight, specifier: "%.1f") ")
//                        Spacer()
//                        Text("Reps: \(set.reps)")
//                    }
//                }
//
//                Divider()
//
//                // Add new set
//                VStack(spacing: 8) {
//                    Text("Add New Set")
//                        .font(.subheadline)
//                    HStack {
//                        Text("Weight")
//                        TextField("Weight", value: $weight, format: .number)
//                            .frame(width: 70)
//                            .textFieldStyle(.roundedBorder)
////                        Text(entry.exercise.weightUnit.rawValue)
//                    }
//                    HStack {
//                        Text("Reps")
//                        TextField("Reps", value: $reps, format: .number)
//                            .frame(width: 70)
//                            .textFieldStyle(.roundedBorder)
//                    }
//                    Button("Add Set") {
//                        let newSet = ExerciseSet(
//                            weight: weight,
//                            reps: reps,
//                            entry: entry
//                        )
//                        Task {
//                            await setVM.addSet(newSet)
//                            // Optionally, update entry.sets locally if needed
//                        }
//                        weight = 0
//                        reps = 0
//                    }
//                    .padding(.top)
//                }
//                .padding()
//
//                Spacer()
//            }
//            .navigationTitle("Edit Sets")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Close") {
//                        // Dismiss logic (parent Sheet)
//                    }
//                }
//            }
//            .onAppear {
//                Task { await setVM.fetchAllSets() }
//            }
//        }
//    }
//}
