//
//  SingleExecutionView.swift
//  MyApplication
//
//  Created by Marco Cerino on 21/02/23.
//

import SwiftUI

struct SingleExecutionView: View {
    let exercisestatic: ExerciseStatic
    
    var body: some View {
        NavigationView{
            Form{
                 GifImage(exercisestatic.image).frame(width: .infinity,height: 300,alignment: .center)
                Section(header: Text("Exercise description")){Text(exercisestatic.description)
                
                }
            }
            .navigationTitle(exercisestatic.exercisenamestatic)
            
        }
    }
}

struct SingleExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleExecutionView(exercisestatic: ExerciseStatic(exercisenamestatic: "Bench Press", description: "descrizione", bodypart: Bodyparts.chest, image: "Panca"))
    }
}
