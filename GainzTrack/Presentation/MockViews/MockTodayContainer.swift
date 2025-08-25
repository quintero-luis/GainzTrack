//
//  MockTodayContainer.swift
//  GainzTrack
//
//  Created by Luis Quintero on 25/08/25.
//

import SwiftUI
import SwiftData

// Función para crear un contenedor de prueba con datos mock
@MainActor
func mockTodayContainer() -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, ExerciseEntry.self, Exercise.self, ExerciseSet.self)
    
    let context = container.mainContext
    
    let todayDate = Calendar.current.startOfDay(for: Date())
    
    let today = Day(date: todayDate)
    
    let exercise = Exercise(name: "Bench Press")
    
    let entry = ExerciseEntry(day: today, exercise: exercise)
    
    entry.sets = [
        ExerciseSet(weight: 95, reps: 5, entry: entry),
        ExerciseSet(weight: 85, reps: 5, entry: entry)
    ]
    
    today.entries = [entry]
    
    // Insertar en el contexto
    context.insert(today)
    context.insert(exercise)
    context.insert(entry)
    entry.sets.forEach { context.insert($0) }
    
    return container
}

