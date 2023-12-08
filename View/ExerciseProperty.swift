//
//  ExerciseProperty.swift
//  MyApplication
//
//  Created by Marco Cerino on 22/02/23.
//

import SwiftUI

struct ExerciseProperty: View {
    var exercisestatic: ExerciseStatic
    //@State var exercises: [Exercise]
    
    @State var sets : String = ""
    @State var rep : String = ""
    @State var selectedMin = 0
    @State var selectedSec = 0
    @EnvironmentObject var workoutStore : WorkoutsStore
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        var exercise = Exercise(exercisestat: exercisestatic)
        NavigationView{
            Form{
                GifImage(exercisestatic.image).frame(width: 500,height: 300,alignment: .center)
                Section(header: Text("Sets"),content: {
                    HStack{
                        Text("N° set:")
                        TextField("1", text: $sets)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            )
                            .accentColor(Color.gray.opacity(0.5))
                        Text("N° reps:")
                        TextField("1", text: $rep)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            )
                            .accentColor(Color.gray.opacity(0.5))
                    }
                    
                })
                Section(header: Text("Rest time"), content: {
                    HStack {
                        // Picker per i minuti
                        Picker("Minuti", selection: $selectedMin) {
                            ForEach(0..<60) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        Text("min")
                        
                        // Picker per i secondi
                        Picker("Secondi", selection: $selectedSec) {
                            ForEach(0..<60) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        Text("sec")
                    }
                })
                
            }.accentColor(.green)
                .navigationBarTitle(exercisestatic.exercisenamestatic, displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {addExercise()}, label: {Text("Add").foregroundColor(.green)}))
        }.accentColor(.green)
    }
    func addExercise(){
        if rep == ""{
            rep="1"
        }
        if sets == ""{
            sets="1"
        }
        var arraySet: [Set] = []
        for index in 1...(Int(sets) ?? 0){
            arraySet.append(Set(reps: Int(rep) ?? 0, weight: 0.0))
        }
        var exercisefin = Exercise(exercisestat: exercisestatic)
        exercisefin.sets = arraySet
        exercisefin.min = selectedMin
        exercisefin.sec = selectedSec
        workoutStore.workouts[workoutStore.workouts.count-1].exercises.append(exercisefin)
        
        dismiss()
        
    }
}


struct ExerciseProperty_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseProperty(exercisestatic: ExerciseStatic(exercisenamestatic: "Bench Press", description: "descrizione", bodypart: Bodyparts.chest, image: "Panca"))
    }
}
