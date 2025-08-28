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
                    Text("Today")
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
            }
            .padding()
            .task {
                // Cargar día de hoy y sus entradas
                await dayVM.loadToday()
                await entryVM.fetchAllEntries()
            }
        } // Navigation Stack
        
    } // View
}

