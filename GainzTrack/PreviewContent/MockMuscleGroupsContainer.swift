//
//  MockMuscleGroupsContainer.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

//import Foundation
//import SwiftData
//
//@MainActor
//func mockMuscleGroupsContainer(with groups: [MuscleGroup] = []) -> ModelContainer {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: MuscleGroup.self, configurations: config)
//    let context = container.mainContext
//    
//    // MARK: Mock Muscle Group Data
//    let defaultMuscleGroups = [
//        MuscleGroup(name: "Legs", exercises: []),
//        MuscleGroup(name: "Chest", exercises: [])
//    ]
//    
//    let groupsToInsert = groups.isEmpty ? defaultMuscleGroups : groups
//    
//    for group in groupsToInsert {
//        context.insert(group)
//    }
//    
//    try? context.save()
//    
//    return container
//}

/*
 for preview:
 #Preview {
     SomeView()
         .modelContainer(
             mockMuscleGroupsContainer(
                 with: [MuscleGroup(name: "Back", exercises: [])]
             )
         )
 }
 
 // Caso 1: no paso nada → mete Legs y Chest
 mockMuscleGroupsContainer()

 // Caso 2: paso mis propios datos → mete solo Back
 mockMuscleGroupsContainer(with: [MuscleGroup(name: "Back", exercises: [])])
 */
