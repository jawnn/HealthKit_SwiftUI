//
//  ContentView.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/7/24.
//

import HealthKit
import SwiftUI
import Observation
import SwiftData

enum SortFilter: Int {
    case date
    case calorieCount
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .tint(.green)
        }
    }
}

struct WorkoutList: View {
    @State private var healthStore = HealthStore()
    
    @State private var isShowingFullHistory: Bool = false
    @State private var isShowingDetails: Bool = false
    @State private var selectedWorkout: Workout? = nil
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Section {
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    KeyValColumn(title: "Move", value: "\(healthStore.ringData.move.decimalString())/\(healthStore.ringData.moveGoal.decimalString())", color: .red, measurement: "CAL")
                                    
                                    KeyValColumn(title: "Exercise", value: "\(healthStore.ringData.exercise.decimalString())/\(healthStore.ringData.exerciseGoal.decimalString())", color: .green, measurement: "MIN")
                                    
                                    KeyValColumn(title: "Stand", value: "\(healthStore.ringData.stand.decimalString())/\(healthStore.ringData.standGoal.decimalString())", color: .blue, measurement: "HRS")
                                }
                                Spacer()
                                ActivityRing(ringData: healthStore.ringData)
                            }
                            
                            Divider()
                            
                            HStack {
                                KeyValColumn(title: "Steps", value: healthStore.steps.formatted(), color: .gray, measurement: "")
                                Spacer()
                                KeyValColumn(title: "Distance", value: healthStore.distance.decimalString(2), color: .gray, measurement: "MI")
                            }
                        }
                    } header: {
                        Text("Activity")
                    }
                    .headerProminence(.increased)
                    
                    Section {
                        ForEach(healthStore.weeklyWorkouts) { workout in
                            NavigationLink {
                                WorkoutDetail(workout: workout)
                            } label: {
                                WorkoutCell(title: workout.title, symbolName: workout.workoutType.symbolName, date: workout.startDate, activeCal: workout.activeCaloriesBurned)
                            }
                        }
                    } header: {
                        HStack {
                            Text("Monthly History")
                            Spacer()
                            
                            NavigationLink {
                                FullWorkoutHistory(workouts: healthStore.workouts)
                            } label: {
                                Text("Show All")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Summary")
            }
            
            if healthStore.isLoading {
                LoadingView()
            }
        }
        .tint(.green)
        .task {
            healthStore.requestAuthorization()
        }
    }
}

#Preview {
    WorkoutList()
}
