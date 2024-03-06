//
//  Double+Extension.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import Foundation

extension Double {
    
    func decimalString(_ places: Int = 0) -> String {
        return String(format: "%.\(places)f", self)
    }
    
}
