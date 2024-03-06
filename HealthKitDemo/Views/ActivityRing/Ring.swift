//
//  Ring.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 3/5/24.
//

import SwiftUI

struct Ring: View {
    let lineWidth: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    let percent: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Track
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: lineWidth))
                    .fill(backgroundColor)
                
                // Animated Ring
                RingShape(percent: percent)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .fill(foregroundColor)
            }   
            .padding(lineWidth / 2)
        }
    }
}
