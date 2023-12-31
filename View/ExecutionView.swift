//
//  ExecutionView.swift
//  MyApplication
//
//

import SwiftUI

struct ExecutionView: View {
    // Dichiarazione della variabile di stato che conterrà il testo di ricerca
    @State var searchText = ""
    
    // Dichiarazione dell'istanza di ExerciseDB, contenente l'array di ExerciseStatic
    var arraystatic = ExerciseDB()
    
    // Definizione di una variabile calcolata che restituisce l'array di ExerciseStatic filtrato in base al testo di ricerca
    var filteredExercises: [ExerciseStatic] {
        if searchText.isEmpty {
            return arraystatic.exercisedb // Se la ricerca è vuota, mostra l'intero array
        } else {
            return arraystatic.exercisedb.filter { exercise in
                exercise.exercisenamestatic.lowercased().contains(searchText.lowercased()) // Se la ricerca non è vuota, filtra gli esercizi che contengono il testo di ricerca
            }
        }
    }
    
    var body: some View {
        NavigationView {
            // Creazione di una lista di esercizi filtrata in base al testo di ricerca
            List{
                ForEach(filteredExercises){ exercise in
                    // Creazione di una cella di esercizio cliccabile che porta alla vista dettagliata dell'esercizio
                    NavigationLink(destination: {SingleExecutionView(exercisestatic: exercise)}, label: {ExerciseStaticCell(exercise: exercise)})
                }            }
            .navigationTitle("Executions").navigationBarTitleDisplayMode(.inline) // Impostazione del titolo della navigazione
            .searchable(text: $searchText) // Creazione di una barra di ricerca con il testo di ricerca bindato alla variabile di stato
        }
        

    }
        
}
struct ExerciseStaticCell: View {
    
    let exercise : ExerciseStatic
    
    var body: some View {
        HStack {
            GifImage(exercise.image).frame(width: 60,height: 60)
            Spacer().frame(width: 30)
            VStack(alignment: .leading, spacing: 10.0) {
                Text(exercise.exercisenamestatic)
                Text(exercise.bodypart.rawValue)
                    .font(.footnote)
                    
            }
            
            Spacer()
            
            
            
        }
        
        
    }
    
}
struct ExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        ExecutionView()
    }
}
