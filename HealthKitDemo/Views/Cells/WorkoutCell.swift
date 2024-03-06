//
//  WorkoutCell.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/9/24.
//

import HealthKit
import SwiftUI

struct WorkoutCell: View {
    var title: String
    var symbolName: String
    var date: Date
    var activeCal: Double
    
    var body: some View {
        HStack(alignment: .center) {
            CircularWorkoutIcon(symbolName: symbolName)

            VStack(alignment: .leading) {
                Text(title.capitalized)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.headline)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(String(format: "%.0f", activeCal))
                        .foregroundStyle(.green)
                        .font(.largeTitle)
                    Text("CAL")
                        .foregroundStyle(.green)
                        .font(.title2)
                    Spacer()
                    Text(date.shortDateStyleString())
                        .font(.caption)
                        
                }
            }
        }
    }
}

#Preview {
    WorkoutCell(title: "Traditional Strength Training Training Training", symbolName: "basketball.fill", date: .now, activeCal: 943)
        .frame(height: 80)
    
}



