//
//  HealthStore.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/7/24.
//

import Foundation
import HealthKit
import Observation
import SwiftData
import SwiftUI

enum HealthError: Error {
    case healthDataNotAvailable
    case noAuthorization
}

class StepData {
    var steps: Int
    var distance: Double
    
    init(steps: Int, distance: Double) {
        self.steps = steps
        self.distance = distance
    }
}

class RingData {
    var move: Double
    var moveGoal: Double
    var exercise: Double
    var exerciseGoal: Double
    var stand: Double
    var standGoal: Double
    
    var mPercent: Double = 0.0
    var ePercent: Double = 0.0
    var sPercent: Double = 0.0
    
    init(move: Double, moveGoal: Double, exercise: Double, exerciseGoal: Double, stand: Double, standGoal: Double) {
        self.move = move
        self.moveGoal = moveGoal
        self.exercise = exercise
        self.exerciseGoal = exerciseGoal
        self.stand = stand
        self.standGoal = standGoal
    }
    
    func percent(cur: Double, max: Double) -> Double {
        return (cur / max) * 100
    }
}

@Observable
class HealthStore {
    var healthStore: HKHealthStore?
    var lastError: Error?
    
    var ringData = RingData(move: 0, moveGoal: 0, exercise: 0, exerciseGoal: 0, stand: 0, standGoal: 0)
    
    var steps: Int = 0
    var distance: Double = 0.0
    var workouts: [Workout] = []
    var monthlyWorkouts: [Workout] = []
    var workoutsToEnter: [HKWorkout] = []
    
    var isLoading: Bool = true
    
    let group = DispatchGroup()
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            lastError = HealthError.healthDataNotAvailable
        }
    }
    
    func dispatchRequest() {
        group.enter()
        print("ring - enter")
        self.fetchRings()
        print("steps - enter")
        group.enter()
        self.fetchStepCount()
        print("workout - enter")
        group.enter()
        self.fetchWorkoutData()
        
        group.notify(queue: .main) {
            print("notify - main")
            self.isLoading = false
        }
    }
    
    func requestAuthorization() {
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(), HKQuantityType(.heartRate),
            HKQuantityType(.stepCount), HKQuantityType(.distanceWalkingRunning),
            HKQuantityType(.appleStandTime), HKQuantityType(.appleMoveTime), HKQuantityType(.appleExerciseTime), HKObjectType.activitySummaryType(), HKQuantityType(.activeEnergyBurned)
        ]
        
        guard let healthStore = self.healthStore else {
            return
        }
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if let error = error {
                print("Error requesting authorization for health data: \(error.localizedDescription)")
            } else {
                if success {
                    self.dispatchRequest()
                } else {
                    print("Authorization denied for workout data")
                }
            }
        }
    }
    
    func fetchRings() {
        let start = Date().startOfDay()
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now, options: .strictStartDate)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            defer {
                print("ring - leave")
                self.group.leave()
            }
            guard let summaries = summaries else {
                print("Failed to fetch activity summary data: \(error?.localizedDescription ?? "")")
                return
            }
            
            if let summary = summaries.first {
                let a = summary.activeEnergyBurnedGoal.doubleValue(for: .kilocalorie())
                let b = summary.exerciseTimeGoal!.doubleValue(for: .minute())
                let c = summary.standHoursGoal!.doubleValue(for: .count())
                
                let x = summary.activeEnergyBurned.doubleValue(for: .kilocalorie())
                let y = summary.appleExerciseTime.doubleValue(for: .minute())
                let z = summary.appleStandHours.doubleValue(for: .count())
                
                let data = RingData(move: x, moveGoal: a, exercise: y, exerciseGoal: b, stand: z, standGoal: c)
                data.mPercent = data.percent(cur: data.move, max: data.moveGoal)
                data.ePercent = data.percent(cur: data.exercise, max: data.exerciseGoal)
                data.sPercent = data.percent(cur: data.stand, max: data.standGoal)
                
                self.ringData = data
            }
        }
        
        healthStore!.execute(query)
    }
    
    func fetchStepCount() {
        
        let start = Date().startOfDay()
        let end = Date().endOfDay()
        
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount),
              let walkDistanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("Step count type is not available.")
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        let stepsQuery = HKStatisticsQuery(quantityType: stepCountType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity()?.doubleValue(for: .count()) else {
                print("Failed to fetch step count data: \(error?.localizedDescription ?? "")")
                return
            }
            
            self.steps = Int(sum)
        }
        
        let distanceQuery = HKStatisticsQuery(quantityType: walkDistanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            defer {
                print("steps - leave")
                self.group.leave()
            }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let result = result, let distance = result.sumQuantity()?.doubleValue(for: .mile()) else {
                return
            }
            
            self.distance = distance
        }
        
        self.healthStore!.execute(stepsQuery)
        self.healthStore!.execute(distanceQuery)
    }
    
    func fetchWorkoutData() {
        let calendar = Calendar.current
        let startDateComponents = DateComponents(year: 2024, month: 1, day: 1)
        let endDateComponents = DateComponents(year: 2024, month: 12, day: 31)
        
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: endDateComponents) else {
            print("bad date")
            return
        }
        
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: .now)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            defer {
                print("workout - leave")
                self.group.leave()
            }
            guard let workouts = samples as? [HKWorkout], error == nil else {
                print("Error fetching workout data: \(error!.localizedDescription)")
                return
            }
            
            var fetched: [Workout] = []
            for workout in workouts {
                var builder = Workout(workout: workout, stats: workout.allStatistics)
                
                if let activeCaloriesBurned = workout.statistics(for: HKQuantityType(.activeEnergyBurned))?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) {
                    builder.activeCaloriesBurned = activeCaloriesBurned
                }
                
                if let restCaloriesBurned = workout.statistics(for: HKQuantityType(.basalEnergyBurned))?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) {
                    builder.restCaloriesBurned = restCaloriesBurned
                }
                
                if let averageHeartRate = workout.statistics(for: HKQuantityType(.heartRate))?.averageQuantity() {
                    let bpm = averageHeartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                    builder.bpm = bpm
                    fetched.append(builder)
                } else {
                    self.getHeartRate(from: workout.startDate, to: workout.endDate) { bpm, error in
                        if let error {
                            print("error: \(error.localizedDescription)")
                            return
                        }
                        guard let bpm = bpm else {
                            print("no result bpm")
                            return
                        }
                        builder.bpm = bpm
                        fetched.append(builder)
                    }
                }
            }

            var x = fetched.sorted(by: {$0.startDate > $1.startDate})
            self.workouts = x
            
            var y = fetched.sorted(by: {$0.startDate > $1.startDate})
            self.monthlyWorkouts = y.filter({ $0.startDate.isInCurrentMonth() })
        }
        
        healthStore.execute(query)
    }
    
    func getHeartRate(from start: Date, to end: Date, completion: @escaping (Double?, Error?) -> Void) {
        guard let healthStore = self.healthStore else {
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictEndDate)
        
        let heartRateQuery = HKStatisticsCollectionQuery(quantityType: HKQuantityType(.heartRate), quantitySamplePredicate: predicate, options: .discreteAverage, anchorDate: start, intervalComponents: DateComponents(minute: 1))
        
        print("hr - enter")
        self.group.enter()
        heartRateQuery.initialResultsHandler = { query, results, error in
            defer {
                print("hr - leave")
                self.group.leave()
            }
            
            if let statsCollection = results {
                var totalHeartbeats: Double = 0
                var totalDurationInMinutes: Double = 0
                
                statsCollection.enumerateStatistics(from: start, to: end) { statistics, stop in
                    if let averageHeartRate = statistics.averageQuantity() {
                        let totalSeconds = statistics.endDate.timeIntervalSince(statistics.startDate)
                        let totalMinutes = totalSeconds / 60.0
                        let beatsPerMinute = averageHeartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                        
                        totalHeartbeats += beatsPerMinute * totalMinutes
                        totalDurationInMinutes += totalMinutes
                    }
                }
                
                let averageHeartRateBPM = totalHeartbeats / totalDurationInMinutes
                completion(averageHeartRateBPM, nil)
            } else {
                completion(nil, error)
            }
        }
        healthStore!.execute(heartRateQuery)
    }
    
    func sortWorkout(by filterTerm: SortFilter) {
        switch filterTerm {
        case .date:
            self.workouts = self.workouts.sorted { $0.startDate > $1.endDate }
        case .calorieCount:
            self.workouts = self.workouts.sorted { $0.totalCaloriesBurned > $1.totalCaloriesBurned }
        }
    }
}

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay()) ?? self
    }
}
