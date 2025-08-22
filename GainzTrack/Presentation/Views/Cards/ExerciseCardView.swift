//
//  ExerciseCardView.swift
//  GainzTrack
//
//  Created by Luis Quintero on 21/08/25.
//

import SwiftUI

struct ExerciseCardView: View {
    let exercise: Exercise
    @Binding var selectedExercise: Exercise?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Nombre del ejercicio
            Text(exercise.name)
                .font(.headline)

            // Listado de sets: peso y reps
            ForEach(exercise.sets) { set in
                HStack {
                    Text(String(format: "%.2f kg", set.weight))
                    Text("\(set.reps) reps")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(selectedExercise?.id == exercise.id ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .onTapGesture {
            selectedExercise = exercise
        }
    }
}



