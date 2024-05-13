//
//  SetView.swift
//  WorkoutTracker

import SwiftUI

struct SetView: View {
    @Binding var set: Set
    
    var body: some View {
        HStack {
            Text("Weight:")
            TextField("Weight", value: $set.weight, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.decimalPad)
            
            Text("Reps:")
            TextField("Reps", value: $set.reps, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
        }
    }
}

//#Preview {
//    SetView()
//}
