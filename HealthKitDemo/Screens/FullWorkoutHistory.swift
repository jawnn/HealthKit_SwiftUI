//
//  FullWorkoutHistory.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 3/5/24.
//

import SwiftUI

struct FullWorkoutHistory: View {
    let workouts: [Workout]
    
    var sortedWorkouts: [Date: [Workout]] = [:]
    
    init(workouts: [Workout]) {
        self.workouts = workouts
        sortedWorkouts = groupWorkoutsByMonth(workouts: workouts)
    }
    
    var body: some View {
        List {
            ForEach(sortedWorkouts.keys.sorted().reversed(), id: \.self) { key in
                Section("\(key.monthAndYearString())") {
                    let monthWorkouts = workoutsForMonth(key)
                    ForEach(monthWorkouts) { workout in
                        NavigationLink {
                            WorkoutDetail(workout: workout)
                        } label: {
                            WorkoutCell(title: workout.title, symbolName: workout.workoutType.symbolName, date: workout.startDate, activeCal: workout.activeCaloriesBurned)
                        }
                    }
                }
                .headerProminence(.increased)
            }
        }
        .navigationTitle("Full History")
    }
    
    private func groupWorkoutsByMonth(workouts: [Workout]) -> [Date: [Workout]] {
        let empty: [Date: [Workout]] = [:]
        return workouts.reduce(into: empty) { partialResult, current in
            let components = Calendar.current.dateComponents([.year, .month], from: current.startDate)
            let date = Calendar.current.date(from: components) ?? .now
            let exisisting = partialResult[date] ?? []
            partialResult[date] = exisisting + [current]
        }
    }
    
    private func workoutsForMonth(_ month: Date) -> [Workout] {
        return sortedWorkouts[month] ?? []
    }
}

#Preview {
    FullWorkoutHistory(workouts: [Workout(endDate: .now, title: "wow", duration: "123", workoutType: .flexibility)])
}
