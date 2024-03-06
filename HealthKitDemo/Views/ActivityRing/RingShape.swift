//
//  RingShape.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 3/5/24.
//

import SwiftUI

struct RingShape: Shape {
    var percent: Double
    let startAngle: Double
    
    typealias AnimatableData = Double
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    
    init(
        percent: Double = 100,
        startAngle: Double = -90
    ) {
        self.percent = percent
        self.startAngle = startAngle
    }
    
    static func percentToAngle(percent: Double, startingAngle: Double) -> Double {
        return (percent / 100 * 360) + startingAngle
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(height, width) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Self.percentToAngle(percent: percent, startingAngle: startAngle)
        
        
        return Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: Angle(degrees: startAngle),
                        endAngle: Angle(degrees: endAngle),
                        clockwise: false)
        }
    }
}
