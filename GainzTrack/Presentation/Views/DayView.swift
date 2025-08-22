//
//  DayView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import SwiftUI
import SwiftData

struct DayView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var dayVM: DayViewModel
    @StateObject var exerciseVM: ExerciseViewModel
    @StateObject var muscleGroupVM: MuscleGroupViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // MARK: Title Date
            if let selectedDay = dayVM.selectedDay {
                Text(selectedDay.date, format: .dateTime.weekday().month().day())
                    .font(.title)
                    .bold()
            } else {
                ProgressView("Loading days…")
                    .font(.title2)
            }
            
            // MARK: Horizontal scroll between days
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(dayVM.days, id: \.id) { day in
                        Text(day.date, format: .dateTime.day().month())
                            .padding()
                            .background(day == dayVM.selectedDay ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(day == dayVM.selectedDay ? .white : .primary)
                            .cornerRadius(8)
                            .onTapGesture {
                                dayVM.selectedDay = day
                                Task {
                                    await muscleGroupVM.fetchAllMuscleGroups()
                                    await exerciseVM.fetchAllExercises()
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            // MARK: Lista vertical de Exercises
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(exerciseVM.exercises, id: \.id) { exercise in
                        ExerciseCardView(
                            exercise: exercise,
                            selectedExercise: $exerciseVM.selectedExercise
                        )
                        .onTapGesture {
                            exerciseVM.selectedExercise = exercise
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .task {
            // Inicializa los repositorios con el ModelContext
            dayVM.setContext(modelContext)
            muscleGroupVM.setContext(modelContext)
            exerciseVM.setContext(modelContext)
            
            // Fetch inicial de días
            await dayVM.fetchAllDays()
            
            // Fetch inicial de muscle groups y exercises si hay un día seleccionado
            if let _ = dayVM.selectedDay {
                await muscleGroupVM.fetchAllMuscleGroups()
                await exerciseVM.fetchAllExercises()
            }
        }
    }
}


                
//import SwiftUI
//import SwiftData
//
//struct DayView: View {
//    @Environment(\.modelContext) private var modelContext
//    
//    @StateObject var dayVM: DayViewModel
//    @StateObject var exerciseVM: ExerciseViewModel
//    @StateObject var muscleGroupVM: MuscleGroupViewModel
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            // MARK: Title Date
//            if let selectedDay = dayVM.selectedDay {
//                Text(selectedDay.date, format: .dateTime.weekday().month().day())
//                    .font(.title)
//                    .bold()
//            } else {
//                ProgressView("Loading days…")
//                    .font(.title2)
//            }
//            
//            // MARK: Horizontal scroll between days
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(dayVM.days, id: \.id) { day in
//                        Text(day.date, format: .dateTime.day().month())
//                            .padding()
//                            .background(day == dayVM.selectedDay ? Color.blue : Color.gray.opacity(0.2))
//                            .foregroundColor(day == dayVM.selectedDay ? .white : .primary)
//                            .cornerRadius(8)
//                            .onTapGesture {
//                                dayVM.selectedDay = day
//                                Task {
//                                    await muscleGroupVM.fetchAllMuscleGroups()
//                                    await exerciseVM.fetchAllExercises()
//                                }
//                            }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            
//            // MARK: Lista vertical de Exercises
//            ScrollView {
//                LazyVStack(spacing: 12) {
//                    ForEach(exerciseVM.exercises, id: \.id) { exercise in
//                        ExerciseCardView(
//                            exercise: exercise,
//                            selectedExercise: $exerciseVM.selectedExercise
//                        )
//                        .onTapGesture {
//                            exerciseVM.selectedExercise = exercise
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//        }
//        .task {
//            // Inicializa los repositorios con el ModelContext
//            dayVM.setContext(modelContext)
//            muscleGroupVM.setContext(modelContext)
//            exerciseVM.setContext(modelContext)
//            
//            // Fetch inicial de días
//            await dayVM.fetchAllDays()
//            
//            // Fetch inicial de muscle groups y exercises si hay un día seleccionado
//            if dayVM.selectedDay != nil {
//                await muscleGroupVM.fetchAllMuscleGroups()
//                await exerciseVM.fetchAllExercises()
//            }
//        }
//    }
//}


//import SwiftUI
//
//struct DayView: View {
//    @StateObject var dayVM: DayViewModel
//    @StateObject var exerciseVM: ExerciseViewModel
//    @StateObject var muscleGroupVM: MuscleGroupViewModel
//
//    var body: some View {
//        VStack(spacing: 16) {
//            // MARK: Title Date
//            if let selectedDay = dayVM.selectedDay {
//                Text(selectedDay.date, format: .dateTime.weekday().month().day())
//                    .font(.title)
//                    .bold()
//            } else {
//                ProgressView("Loading days…")
//                    .font(.title2)
//            }
//
//            // MARK: Horizontal scroll between days
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(dayVM.days, id: \.id) { day in
//                        Text(day.date, format: .dateTime.day().month())
//                            .padding()
//                            .background(day == dayVM.selectedDay ? Color.blue : Color.gray.opacity(0.2))
//                            .foregroundColor(day == dayVM.selectedDay ? .white : .primary)
//                            .cornerRadius(8)
//                            .onTapGesture {
//                                dayVM.selectedDay = day
//                                Task {
//                                    await muscleGroupVM.fetchAllMuscleGroups()
//                                    await exerciseVM.fetchAllExercises()
//                                }
//                            }
//                    }
//                }
//                .padding(.horizontal)
//            }
//
//            // MARK: Lista vertical de Exercises
//            ScrollView {
//                LazyVStack(spacing: 12) {
//                    ForEach(exerciseVM.exercises, id: \.id) { exercise in
//                        ExerciseCardView(
//                            exercise: exercise,
//                            selectedExercise: $exerciseVM.selectedExercise
//                        )
//                        .onTapGesture {
//                            exerciseVM.selectedExercise = exercise
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//        }
//        .task {
//            // Fetch inicial de días, muscle groups y exercises
//            await dayVM.fetchAllDays()
//
//            // Si hay un día seleccionado después del fetch
//            if dayVM.selectedDay != nil {
//                await muscleGroupVM.fetchAllMuscleGroups()
//                await exerciseVM.fetchAllExercises()
//            }
//        }
//    }
//}


//#Preview {
//    DayView()
//}
