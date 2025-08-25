//
//  TodayView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Day.date) private var days: [Day] // Todos los días
    
    private var today: Day? {
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)!
        return days.first(where: { $0.date >= todayStart && $0.date < todayEnd })
    }
    
    var body: some View {
        VStack {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            if let today = today {
                if today.entries.isEmpty {
                    Text("No exercises yet")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(today.entries) { entry in
                            if let exercise = entry.exercise {
                                Section(header: Text(exercise.name)) {
                                    ForEach(entry.sets) { set in
                                        Text("\(Int(set.weight)) kg x \(set.reps) reps")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("No day created for today")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}


//struct TodayView: View {
//    @Environment(\.modelContext) private var context
//    
//    // Pedimos solo el día actual (si existe en DB)
//    @Query(filter: #Predicate<Day> { Calendar.current.isDateInToday($0.date) })
//    private var todayDays: [Day]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Today")
//                .font(.largeTitle)
//                .bold()
//            
//            if let today = todayDays.first {
//                if today.exercises.isEmpty {
//                    Text("No exercises yet")
//                        .foregroundColor(.gray)
//                } else {
//                    List {
//                        ForEach(today.exercises) { entry in
//                            if let exercise = entry.exercise {
//                                Section(header: Text(exercise.name).font(.headline)) {
//                                    ForEach(entry.sets) { set in
//                                        Text("\(Int(set.weight)) kg x \(set.reps) reps")
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            } else {
//                Text("No day created for today")
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//    }
//}


//struct TodayView: View {
//    @ObservedObject var dayVM: DayViewModel
//    @ObservedObject var entryVM: ExerciseEntryViewModel
//    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
//    @ObservedObject var exerciseVM: ExerciseViewModel
//    @ObservedObject var setVM: ExerciseSetViewModel
//
//    @State private var showAddExerciseSheet = false
//    @State private var showEditSetsSheet: ExerciseEntry?
//
//    var body: some View {
//        VStack {
//            Text("Today: \(dayVM.selectedDay?.date.formatted() ?? "No Date")")
//                .font(.title)
//                .padding()
//
//            Button("Add Exercise") {
//                showAddExerciseSheet = true
//            }
//            .padding()
//            .sheet(isPresented: $showAddExerciseSheet) {
//                MuscleGroupPickerView(
//                    muscleGroupVM: muscleGroupVM,
//                    exerciseVM: exerciseVM,
//                    entryVM: entryVM,
//                    dayVM: dayVM
//                )
//            }
//
//            // List of Exercises for Today
//            if let entries = entryVM.entries, !entries.isEmpty {
//                List(entries) { entry in
//                    VStack(alignment: .leading) {
//                        Text(entry.exercise?.name ?? "Default")
//                            .font(.headline)
//                        ForEach(entry.sets) { set in
//                            let weightText = "Weight: \(set.weight.formatted()) \(entry.exer)"
//                            HStack {
//                                Text(weightText)
//                                Text()
//                            }
//                        }
//                    }
//                    .onTapGesture {
//                        showEditSetsSheet = entry
//                    }
//                }
//            } else {
//                Text("No exercises added today.")
//            }
//        }
//        // Sheet for editing sets
//        .sheet(item: $showEditSetsSheet) { entry in
//            EditSetsView(entry: entry, setVM: setVM)
//        }
//        .onAppear {
//            Task { await entryVM.fetchAllEntries() }
//        }
//    }
//}
