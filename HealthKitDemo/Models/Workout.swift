//
//  Workout.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/9/24.
//

import Foundation
import HealthKit
import SwiftData

class Workout: Identifiable, Hashable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let title: String
    let duration: String
    let workoutType: HKWorkoutActivityType
    
    var activeCaloriesBurned: Double = 0
    var restCaloriesBurned: Double = 0
    let stats: [HKQuantityType: HKStatistics]
    
    var totalCaloriesBurned: Double {
        get {
            return self.activeCaloriesBurned + self.restCaloriesBurned
        }
    }
    
    var distance: Double? {
        guard let distance = stats[HKQuantityType(.distanceWalkingRunning)]?.sumQuantity()?.doubleValue(for: HKUnit.mile()) else {
            return nil
        }
        return distance
    }
    
    var bpm: Double = 0
    
    init(id: UUID = UUID(), startDate: Date = Date(), endDate: Date, title: String, duration: String, workoutType: HKWorkoutActivityType, stats: [HKQuantityType: HKStatistics] = [:]) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
        self.duration = duration
        self.workoutType = workoutType
        self.stats = stats
    }
    
    init(workout: HKWorkout, stats: [HKQuantityType: HKStatistics]) {
        self.id = workout.uuid
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.title = workout.workoutActivityType.title
        self.duration = workout.duration.durationString()
        self.workoutType = workout.workoutActivityType
        self.stats = stats
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct MockData {
    static let workout = Workout(endDate: .now, title: "Basketball", duration: "0:05:10", workoutType: .basketball)
}
