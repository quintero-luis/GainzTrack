//
//  MuscleGroupPickerView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

import SwiftUI

struct MuscleGroupPickerView: View {
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var entryVM: ExerciseEntryViewModel

    // Selección de exercise en la UI
    @State private var selectedExercise: Exercise?

    // Mostrar sheets para crear MuscleGroup o Exercise
    @State private var showAddMuscleGroupSheet = false
    @State private var showAddExerciseSheet = false

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
                                AddMuscleGroupView(viewModel: muscleGroupVM)
                            } label: {
                                Label("MuscleGroup add", systemImage: "plus.circle")
                            }
                        
                        if muscleGroupVM.selectedMuscleGroup != nil {
                            Button("+ Exercise") { showAddExerciseSheet = true }
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

// MARK: - Crear MuscleGroup
struct AddMuscleGroupView: View {
    @ObservedObject var viewModel: MuscleGroupViewModel
    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Muscle Group Name", text: $name)
                Button("Save") {
                    Task {
                        let mg = MuscleGroup(name: name)
                        await viewModel.addMuscleGroup(mg)
                    }
                }
            }
            .navigationTitle("New Muscle Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    
                }
            }
        }
    }
}

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

//struct MuscleGroupPickerView: View {
//    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
//    @ObservedObject var entryVM: ExerciseEntryViewModel
//    @Binding var isPresented: Bool
//
//    @State private var selectedExercise: Exercise?
//    @State private var showAddExerciseSheet = false
//    @State private var showAddMuscleGroupSheet = false
//    @State private var showAddSetSheet = false
//    @State private var newEntry: ExerciseEntry?
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                // 1️⃣ Lista de MuscleGroups
//                List(muscleGroupVM.muscleGroups, id: \.id) { mg in
//                    Button(mg.name) { muscleGroupVM.selectedMuscleGroup = mg }
//                        .foregroundColor(muscleGroupVM.selectedMuscleGroup?.id == mg.id ? .blue : .primary)
//                }
//
//                // 2️⃣ Lista de ejercicios del MuscleGroup seleccionado
//                if let mg = muscleGroupVM.selectedMuscleGroup {
//                    Text("Exercises in \(mg.name)").font(.headline).padding(.top)
//                    List(mg.exercises, id: \.id) { exercise in
//                        Button(exercise.name) { selectedExercise = exercise }
//                            .foregroundColor(selectedExercise?.id == exercise.id ? .blue : .primary)
//                    }
//                }
//
//                // 3️⃣ Botón para añadir ExerciseEntry
//                if let exercise = selectedExercise {
//                    Button("Add \(exercise.name) to Today") {
//                        Task {
//                            guard let day = entryVM.dayVM.selectedDay else { return }
//                            let entry = ExerciseEntry(day: day, exercise: exercise)
//                            await entryVM.addEntry(entry)
//                            newEntry = entry
//                            showAddSetSheet = true // Abrir sheet para agregar sets
//                        }
//                    }
//                    .padding()
//                    .buttonStyle(.borderedProminent)
//                }
//            }
//            .navigationTitle("Select Muscle Group")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Close") { isPresented = false }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    HStack {
//                        Button("+ MG") { showAddMuscleGroupSheet = true }
//                        if muscleGroupVM.selectedMuscleGroup != nil {
//                            Button("+ Exercise") { showAddExerciseSheet = true }
//                        }
//                    }
//                }
//            }
//            // Sheets para crear MuscleGroup o Exercise
//            .sheet(isPresented: $showAddMuscleGroupSheet) {
//                AddMuscleGroupView(viewModel: muscleGroupVM, isPresented: $showAddMuscleGroupSheet)
//            }
//            .sheet(isPresented: $showAddExerciseSheet) {
//                if let mg = muscleGroupVM.selectedMuscleGroup {
//                    AddExerciseView(muscleGroup: mg, isPresented: $showAddExerciseSheet)
//                }
//            }
//            // Sheet para agregar sets al ExerciseEntry recién creado
//            .sheet(isPresented: $showAddSetSheet) {
//                if let entry = newEntry {
//                    AddSetsView(entry: entry, isPresented: $showAddSetSheet)
//                }
//            }
//            // Cargar muscleGroups al aparecer
//            .task { await muscleGroupVM.fetchAllMuscleGroups() }
//        }
//    }
//}
//
//// MARK: - Crear ExerciseSets
//struct AddSetsView: View {
//    @ObservedObject var entry: ExerciseEntry
//    @Binding var isPresented: Bool
//    @Environment(\.modelContext) private var context
//
//    @State private var weight: String = ""
//    @State private var reps: String = ""
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section(header: Text("Add Set")) {
//                    TextField("Weight (kg)", text: $weight)
//                        .keyboardType(.decimalPad)
//                    TextField("Reps", text: $reps)
//                        .keyboardType(.numberPad)
//                    Button("Add Set") {
//                        guard let w = Double(weight), let r = Int(reps) else { return }
//                        let set = ExerciseSet(weight: w, reps: r)
//                        set.entry = entry
//                        entry.sets.append(set)
//                        context.insert(set)
//                        // Limpiar campos
//                        weight = ""
//                        reps = ""
//                    }
//                }
//
//                if !entry.sets.isEmpty {
//                    Section(header: Text("Sets added")) {
//                        ForEach(entry.sets, id: \.id) { set in
//                            Text("\(Int(set.weight)) kg x \(set.reps) reps")
//                        }
//                    }
//                }
//
//                Button("Done") { isPresented = false }
//                    .padding()
//                    .buttonStyle(.borderedProminent)
//            }
//            .navigationTitle("Add Sets")
//        }
//    }
//}
