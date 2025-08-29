//
//  TodayView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 24/08/25.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @ObservedObject var dayVM: DayViewModel
    @ObservedObject var muscleGroupVM: MuscleGroupViewModel
    @ObservedObject var exerciseVM: ExerciseViewModel
    @ObservedObject var entryVM: ExerciseEntryViewModel
    @ObservedObject var setVM: ExerciseSetViewModel
    
    private var today: Day? {
        dayVM.selectedDay
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                Button(action: { dayVM.selectPreviousDay() }) {
                Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Button(action: { dayVM.selectNextDay() }) {
                Image(systemName: "chevron.right")
                }
                }
                .padding(.horizontal)

                
                ScrollView(.horizontal) {
                    HStack {
                        Text(Calendar.current.isDate(today?.date ?? Date(), inSameDayAs: Date()) ? "Today" : "No")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading)
                        
                        Spacer()
                        
                        if let today = today {
                            NavigationLink { // Go to Muscle Group List View
                                MuscleGroupPickerView(
                                    muscleGroupVM: muscleGroupVM,
                                    exerciseVM: exerciseVM,
                                    entryVM: entryVM,
                                    setVM: setVM,
                                    today: today
                                )
                            }
                            label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 20))
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4, x: 0, y: 2)
                            }
                            .padding()
                        } else {
                            Text("Loading day")
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    
                    if let today = today {
                        if entryVM.entries.isEmpty {
                            Text("No exercises yet")
                                .foregroundColor(.gray)
                        } else {
                            List {
                                ForEach(entryVM.entries, id: \.id) { entry in
                                    if let exercise = entry.exercise {
                                        Section(header: Text(exercise.name)) {
                                            ForEach(entry.sets, id: \.id) { set in
                                                Text("\(Int(set.weight)) kg x \(set.reps) reps")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Text("No exercises added today")
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    
                    
                    Spacer()
                } // HScroll
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -10 {
                                 dayVM.selectNextDay()
                            } else if value.translation.width > 10 {
                                // Swipe hacia derecha → día anterior
                                dayVM.selectPreviousDay()
                            }
                        }
                )
            } // VStack
            .padding()
            .task {
                // Cargar día de hoy y sus entradas
                await dayVM.loadToday()
                await entryVM.fetchAllEntries()
            }
        } // Navigation Stack
        
    } // View
}

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
    
    TodayView(
        dayVM: dayVM,
        muscleGroupVM: muscleGroupVM,
        exerciseVM: exerciseVM,
        entryVM: entryVM,
        setVM: setVM
    )
}

/*
 HStack {
 Button(action: { dayVM.selectPreviousDay() }) {
 Image(systemName: "chevron.left")
 }
 
 Spacer()
 
 Button(action: { dayVM.selectNextDay() }) {
 Image(systemName: "chevron.right")
 }
 }
 .padding(.horizontal)
 */
