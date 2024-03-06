//
//  CircularWorkoutIcon.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import SwiftUI

struct CircularWorkoutIcon: View {
    let symbolName: String
    
    var body: some View {
        Image(systemName: symbolName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .padding(12)
            .foregroundStyle(Color.green)
            .background(LinearGradient(colors: [Color.black, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(Circle())
    }
}

#Preview {
    CircularWorkoutIcon(symbolName: "figure.core.training")
}
