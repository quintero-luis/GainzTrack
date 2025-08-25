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

#Preview {
    TodayView()
        .modelContainer(mockTodayContainer())
}
