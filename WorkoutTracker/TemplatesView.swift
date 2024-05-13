//
//  TemplatesView.swift
//  WorkoutTracker

import SwiftUI

struct TemplatesView: View {
    
    // fetch all the user's workouts from db and assign to workouts property
    let workouts: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs]
    @State private var isEditViewPresented = false // State to track if the EditTemplateView is presented
    
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
//                            NavigationLink(
//                                destination: EditTemplateView(workout: nil, editViewPresented: $isEditViewPresented),
//                                label: {
//                                    Image(systemName: "plus")
//                                        .foregroundColor(.black)
//                                }
//                            )
                            Button {
                                isEditViewPresented = true
//                                EditTemplateView(workout: nil, editViewPresented: $isEditViewPresented)
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $isEditViewPresented) {
                                EditTemplateView(workout: nil, editViewPresented: $isEditViewPresented)
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
                                
                                KebabMenu(workout: workout, isEditViewPresented: $isEditViewPresented)
                                    .padding(.trailing)
                                    .foregroundColor(.black)
                                    .offset(y: 15)
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

struct KebabMenu: View {
    let workout: Workout
    @Binding var isEditViewPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    Button(action: {
                        isEditViewPresented = true // Show EditTemplateView
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
                .fullScreenCover(isPresented: $isEditViewPresented) {
//                    NavigationView {
                        EditTemplateView(workout: workout, editViewPresented: $isEditViewPresented)
//                    }
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
