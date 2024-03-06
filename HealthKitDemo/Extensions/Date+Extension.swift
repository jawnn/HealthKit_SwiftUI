//
//  Date+Extension.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import Foundation

extension Date {
    func isInCurrentWeek() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInThisWeek(self)
    }
    
    func isInCurrentMonth() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInThisMonth(self)
    }
    
    func shortDateStyleString() -> String {
        let formatter = DateFormatter()
        if self.isInCurrentWeek() {
            formatter.dateFormat = "EEEE"
        } else {
            formatter.dateStyle = .short
        }
        return formatter.string(from: self)
    }
    
    func hoursAndMinuteString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
    
    func monthAndYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
}
