//
//  TimeInterval+Extension.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import Foundation

extension TimeInterval {
    func durationString() -> String {
        let formatter = DateComponentsFormatter()
        return formatter.string(from: self) ?? "no date"
    }
}
