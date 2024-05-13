//
//  TemplatesView.swift
//  WorkoutTracker

import SwiftUI

struct TemplatesView: View {
    
    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs, SampleWorkouts.push]
    @State private var isEditViewFromPlusPresented = false
    @State private var isEditViewFromKebabPresented = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Workout")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                    .padding()
                    .font(.title2)
                    .fontWeight(.bold)
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("My Templates")
                            Spacer()
                            Button {
                                isEditViewFromPlusPresented = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $isEditViewFromPlusPresented) {
                                EditTemplateView(workout: nil, editViewFromPlusPresented: $isEditViewFromPlusPresented, editViewFromKebabPresented: $isEditViewFromKebabPresented)
                            }
                        }
                        .font(.title2)
                        .bold()
                        .padding()
                        
                        ForEach(workouts) { workout in
                            ZStack {
                                NavigationLink(destination: ActiveWorkoutView(workout: workout)) {
                                    TemplateView(workout: workout)
                                        .border(Color.black, width: 1)
                                        .cornerRadius(10)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                                .contentShape(Rectangle())
                                
                                if !isEditViewFromPlusPresented { // Check if already presented from "plus" button
                                    KebabMenu(workout: workout, isEditViewFromKebabPresented: $isEditViewFromKebabPresented)
                                        .padding(.trailing)
                                        .foregroundColor(.black)
                                        .offset(y: 15)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

struct KebabMenu: View {
    let workout: Workout
    @Binding var isEditViewFromKebabPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    Button(action: {
                        isEditViewFromKebabPresented = true
                        print("Editing \(workout.name)")
                    }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(action: {
                        // Implement delete action here
                        print("Delete workout")
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                }
                .padding(.trailing) // Adjust the padding as needed
                .frame(width: 40, height: 40) // Increase tap area size
                .fullScreenCover(isPresented: $isEditViewFromKebabPresented) {
                    EditTemplateView(workout: workout, editViewFromPlusPresented: .constant(false), editViewFromKebabPresented: $isEditViewFromKebabPresented)
                }
            }
            Spacer()
        }
        .padding(.top) // move the kebab menu down slightly
    }
}




#Preview {
    TemplatesView()
}
