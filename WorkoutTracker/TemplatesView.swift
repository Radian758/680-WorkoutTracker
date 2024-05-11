//
//  TemplatesView.swift
//  WorkoutTracker

import SwiftUI

struct TemplatesView: View {
    
    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Workout")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("My Templates")
                            Spacer()
                            Image(systemName: "plus")
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        
                        ForEach(workouts) { workout in
                            NavigationLink(destination: ActiveWorkoutView(workout: workout)) {
                                TemplateView(workout: workout)
                                    .border(Color.black, width: 1)
                                    .cornerRadius(10)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                        } // foreach
                    }
                    .padding()
                } // ScrollView
            } // VStack
            .background(Color(UIColor.systemGroupedBackground))
        } // navigationview
    } // body
}




#Preview {
    TemplatesView()
}
