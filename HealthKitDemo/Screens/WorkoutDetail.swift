//
//  WorkoutDetail.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import SwiftUI

enum WorkoutDetailData: Int {
    case workoutTime
    case distance
    case activeCalories
    case totalCalories
    case bpm
}

struct WorkoutDetail: View {
    let workout: Workout
    var body: some View {
        List {
            HStack(alignment: .center) {
                CircularWorkoutIcon(symbolName: workout.workoutType.symbolName)
                VStack(alignment: .leading) {
                    Text(workout.title)
                    Text("\(workout.startDate.hoursAndMinuteString())-\(workout.endDate.hoursAndMinuteString())")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.leading, 16)
                Spacer()
            }
            .listRowBackground(Color.clear)
            
            Section("Workout Details") {
                HStack {
                    VerticalHeaderStatView(title: "Workout Time", value: workout.duration)
                    Spacer()
                    VerticalHeaderStatView(title: "Active Calories", value: workout.activeCaloriesBurned.decimalString(), measurement: "CAL")
                }
                HStack {
                    VerticalHeaderStatView(title: "Total Calories", value: workout.totalCaloriesBurned.decimalString(), measurement: "CAL")
                    Spacer()
                    VerticalHeaderStatView(title: "Avg. Heart Rate", value: workout.bpm.decimalString(), measurement: "BPM")
                }
                if let distance = workout.distance {
                    VerticalHeaderStatView(title: "Distance", value: distance.decimalString(2), measurement: "MI")
                }
            }
        }
        .navigationTitle(workout.startDate.shortDateStyleString())
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WorkoutDetail(workout: MockData.workout)
}

struct VerticalHeaderStatView: View {
    let title: String
    let value: String
    let measurement: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.title2)
                if let measurement {
                    Text(measurement)
                        .font(.headline)
                }
            }
        }
    }
    
    init(title: String, value: String, measurement: String? = nil) {
        self.title = title
        self.value = value
        self.measurement = measurement
    }
}
