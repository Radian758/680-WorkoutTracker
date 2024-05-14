//
//  TemplatesView.swift
//  WorkoutTracker

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct TemplatesView: View {
    
    @FirestoreQuery var workoutTemplates: [Workout]
//        let workoutTemplates: [Workout] = [SampleWorkouts.push, SampleWorkouts.legs, SampleWorkouts.push]
    @State private var isEditViewNewWorkoutPresented = false
    @State private var isPresentingEditWorkout: Workout? = nil
    @State private var isPresentingActiveWorkout: Workout? = nil
    let userId: String
    
    init(userId: String) {
        print("IN INIT TEMPLATESVIEW")
        self.userId = userId
        let firestorePath = "/users/\(userId)/workoutTemplates/"
        self._workoutTemplates = FirestoreQuery(collectionPath: firestorePath)
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
                                isEditViewNewWorkoutPresented = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $isEditViewNewWorkoutPresented) {
                                EditTemplateView(workout: nil, editViewNewWorkoutPresented: $isEditViewNewWorkoutPresented)
                            }
                        }
                        .padding()
                        
                        ForEach(workoutTemplates) { workout in
                            Button {
                                isPresentingActiveWorkout = workout
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
                                                deleteWorkout(workout)
                                            }) {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            .padding(.trailing)
                                            
                                            Button(action: {
                                                print("Edit workout")
                                                isPresentingEditWorkout = workout
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .padding(.trailing)
                                            
                                            //                                            Button(action: {
                                            //                                                // Action to start the workout
                                            //                                            }) {
                                            //                                                Image(systemName: "play.circle.fill")
                                            //                                                    .font(.system(size: 30))
                                            //                                                    .foregroundColor(.green)
                                            //                                            }
                                        }
                                    }
                                }
                            }
                            
                        } // foreach
                        .fullScreenCover(item: $isPresentingEditWorkout) { workout in
                            EditTemplateView(workout: workout, editViewNewWorkoutPresented: $isEditViewNewWorkoutPresented)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .fullScreenCover(item: $isPresentingActiveWorkout) { workout in
                ActiveWorkoutView(workout: workout)
            }
        }
//        .onAppear {
//            fetchWorkoutTemplates()
//        }
    }
    
//    private func fetchWorkoutTemplates() {
//            let db = Firestore.firestore()
//            db.collection("users/\(userId)/workoutTemplates").getDocuments { querySnapshot, error in
//                if let error = error {
//                    print("Error fetching workout templates: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents found")
//                    return
//                }
//                
//                self.workoutTemplates = documents.compactMap { document in
//                    do {
//                        let workout = try document.data(as: Workout.self)
//                        return workout
//                    } catch {
//                        print("Error decoding workout: \(error)")
//                        return nil
//                    }
//                }
//            }
//        }
    
    
    private func deleteWorkout(_ workout: Workout) {
        // Remove the workout from Firestore
        Firestore.firestore().collection("users/\(userId)/workoutTemplates").document(workout.id).delete { error in
            if let error = error {
                print("Error deleting workout: \(error.localizedDescription)")
            } else {
                print("Workout deleted successfully")
                // After successfully deleting the workout from Firestore, you may want to refresh the workoutTemplates array
                // Since it's derived from FirestoreQuery, it should update automatically, but you can also manually refresh it if needed
                // This depends on how you've implemented FirestoreQuery
            }
        }
    }
}

#Preview {
    TemplatesView(userId: "RWU9NGSa9aSEaw257Um3ka3rJk22")
}
