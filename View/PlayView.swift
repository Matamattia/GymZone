//
//  PlayView.swift
//  MyApplication
//
//  Created by Giosuè Ciaravola on 23/02/23.


import SwiftUI
struct PlayView: View {
    @EnvironmentObject var workoutStore: WorkoutsStore
    @State var isNextView = false
    @State var isFinalView = false
    var workoutindex: Int
    var exerciseindex: Int
    @State var newWeight = [String](repeating: "", count: 20)
    @State var secondsRemaining = 0
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            }
        }
    }
    
   

    var body: some View {
        NavigationView {
            Form {
                GifImage(workoutStore.workouts[workoutindex].exercises[exerciseindex].exercisestat.image)
                    .frame(width: 500, height: 300, alignment: .center)
              

                Section(header:Text("Rest Timer"), content: {
                    Text(String(format: "%02d:%02d", secondsRemaining / 60, secondsRemaining % 60))
                    HStack {
                        Button("Start Timer") {
                            secondsRemaining = workoutStore.workouts[workoutindex].exercises[exerciseindex].min * 60 + workoutStore.workouts[workoutindex].exercises[exerciseindex].sec
                            _ = timer

                        }
                    }
                        HStack{
                            Button("Reset Timer") {
                                secondsRemaining = 0
                            }
                        }

                })
                
                Section(header: Text("Sets"), content: {
                    ForEach(0..<workoutStore.workouts[workoutindex].exercises[exerciseindex].sets.count) { index2 in
                        HStack {
                            Text("\(index2+1). reps: \(workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index2].reps)    weight: ")
                            TextField("\(String(format: "%.1f", workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index2].weight))",text: $newWeight[index2]).textFieldStyle(PlainTextFieldStyle()).padding().foregroundColor(.black).font(.system(size: 16)).bold() //modifica 1
                        }
                    }
                })
            }
            .navigationTitle(workoutStore.workouts[workoutindex].exercises[exerciseindex].exercisestat.exercisenamestatic)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: { nextset() }, label: { Text("Next") })
                }
            }
            
            if isFinalView {
                EmptyView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .background(
            NavigationLink(destination: PlayView(workoutindex: workoutindex, exerciseindex: exerciseindex+1).navigationBarBackButtonHidden(true), isActive: $isNextView) {
                EmptyView()
            }
        )
        .background(
            NavigationLink(destination: WorkoutView(workout: workoutStore.workouts[workoutindex]).navigationBarBackButtonHidden(true), isActive: $isFinalView) {
                EmptyView()
            }
        )
    }
    
        func nextset() {
            for index in 0..<workoutStore.workouts[workoutindex].exercises[exerciseindex].sets.count {
                if newWeight[index] == "" {
                    newWeight[index] = "0"
                }
                workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index].weight = Double(newWeight[index])!
            }
    
            if workoutStore.workouts[workoutindex].exercises.count-1 == exerciseindex {
                isFinalView.toggle()
            } else {
                isNextView.toggle()
            }
        }
    }
