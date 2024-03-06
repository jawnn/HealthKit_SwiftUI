//
//  KeyValColumn.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 3/5/24.
//

import SwiftUI

struct KeyValColumn: View {
    let title: String
    let value: String
    let color: Color
    let measurement: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(value)
                    .foregroundStyle(color)
                    .fontWeight(.semibold)
                Text(measurement)
                    .foregroundStyle(color)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    KeyValColumn(title: "Move", value: "95/600", color: .red, measurement: "CAL")
}
