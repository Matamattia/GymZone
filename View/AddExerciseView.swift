//
//  AddExerciseView.swift
//  MyApplication
//
//

import SwiftUI

struct AddExerciseView: View {
    //var exercises: [Exercise]
    @State var searchText = ""
//    @State var staticex = ExerciseStatic(exercisenamestatic: "Dio prova", description: "descrizione", bodypart: Bodyparts.biceps, image: "image")
    @Environment(\.dismiss) private var dismiss
//    @State var showingExercise = false
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
                    NavigationLink(destination: {ExerciseProperty(exercisestatic: exercise)}, label: {ExerciseStaticCell(exercise: exercise)})
//                    Button(action: {newexercise(exercise: exercise)}, label: {ExerciseStaticCell(exercise: exercise)})
                }
            }
            .navigationTitle("Exercises").navigationBarTitleDisplayMode(.inline) // Impostazione del titolo della navigazione
            .navigationBarItems(leading: Button(action: {
                
                dismiss()//chiudo la finestra
                
            }, label: {Text("Cancel").foregroundColor(.green)}))
            .searchable(text: $searchText) // Creazione di una barra di ricerca con il testo di ricerca bindato alla variabile di stato
        }.accentColor(.green)
//        .sheet(isPresented: $showingExercise, content: {ExerciseProperty(exercisestatic: staticex, exercises: exercises)})
    }
//    func newexercise(exercise: ExerciseStatic) {
////        staticex = ExerciseStatic(exercisenamestatic: "Dio madonna", description: "descrizione", bodypart: Bodyparts.biceps, image: "image")
//        staticex = exercise
//        showingExercise.toggle()
//    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        
        AddExerciseView()
    }
}
