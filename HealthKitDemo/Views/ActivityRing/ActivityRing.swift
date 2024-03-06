//
//  ActivityRing.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 3/5/24.
//

import SwiftUI

typealias MoveRing = Ring
typealias ExerciseRing = Ring
typealias StandRing = Ring

struct ActivityRing: View {
    let ringData: RingData
    var body: some View {
        ZStack {
            StandRing(lineWidth: 15,
                 backgroundColor: Color.blue.opacity(0.2),
                 foregroundColor: .blue,
                 percent: ringData.sPercent
            )
            .frame(width: 80, height: 80)
            .animation(.easeInOut (duration: 1), value: ringData.sPercent)
            
            ExerciseRing(lineWidth: 15,
                 backgroundColor: Color.green.opacity(0.2),
                 foregroundColor: .green,
                 percent: ringData.ePercent
            )
            .frame(width: 112, height: 112)
            .animation(.easeInOut(duration: 1), value: ringData.ePercent)
            
            MoveRing(lineWidth: 15,
                 backgroundColor: Color.red.opacity(0.2),
                 foregroundColor: .red,
                 percent: ringData.mPercent
            )
            .frame(width: 144, height: 144)
            .animation(.easeInOut(duration: 1), value: ringData.mPercent)
        }
    }
}

#Preview {
    ActivityRing(ringData: RingData(move: 89, moveGoal: 600, exercise: 2, exerciseGoal: 45, stand: 4, standGoal: 10))
}
