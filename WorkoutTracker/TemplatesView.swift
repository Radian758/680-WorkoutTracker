//
//  TemplatesView.swift
//  WorkoutTracker

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct TemplatesView: View {
    
    @StateObject var viewModel: TemplatesViewModel
//    @State var workoutTemplates: [Workout] = []
//        let workoutTemplates: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs, SampleWorkouts.push]
    let userId: String
    
    init(userId: String) {
        print("IN INIT TEMPLATESVIEW")
        self.userId = userId
//        let firestorePath = "/users/\(userId)/workoutTemplates/"
//        self._workoutTemplates = FirestoreQuery(collectionPath: firestorePath)
        self._viewModel = StateObject(
            wrappedValue: TemplatesViewModel(userId: userId)
        )
    }
    
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
                                .font(.title2)
                                .bold()
                            Spacer()
                            Button {
                                viewModel.isEditViewNewWorkoutPresented = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $viewModel.isEditViewNewWorkoutPresented) {
                                EditTemplateView(workout: nil, editViewNewWorkoutPresented: $viewModel.isEditViewNewWorkoutPresented)
                            }
                        }
                        .padding()
                        
                        ForEach(viewModel.workoutTemplates) { workout in
                            Button {
                                viewModel.isPresentingActiveWorkout = workout
                                print(workout)
                            } label: {
                                ZStack {
                                    TemplateView(workout: workout)
                                        .border(Color.black, width: 1)
                                        .cornerRadius(10)
                                        .padding()
                                        .foregroundColor(.black)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                print("Delete workout")
                                                viewModel.deleteWorkout(workout)
                                            }) {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            .padding(.trailing)
                                            
                                            Button(action: {
                                                print("Edit workout")
                                                viewModel.isPresentingEditWorkout = workout
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .padding(.trailing)
                                        }
                                    }
                                }
                            }
                            
                        } // foreach
                        .fullScreenCover(item: $viewModel.isPresentingEditWorkout) { workout in
                            EditTemplateView(workout: workout, editViewNewWorkoutPresented: $viewModel.isEditViewNewWorkoutPresented)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .fullScreenCover(item: $viewModel.isPresentingActiveWorkout) { workout in
                ActiveWorkoutView(workout: workout)
            }
        }
        .onAppear {
            viewModel.fetchWorkoutTemplates()
        }
    }

}

#Preview {
    TemplatesView(userId: "RWU9NGSa9aSEaw257Um3ka3rJk22")
}
