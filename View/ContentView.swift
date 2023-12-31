//
//  ContentView.swift
//  MyApplication
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var profile=Profilo()
    @State var showingAddView = false
    @State var showingCalendar = false
    @StateObject var workoutStoreNew = WorkoutsStore()
    @State private var selection: Int? = 0
    @State var showAlert1 = false// per errore nel caso di dati non compilati x scheda
    @State var showAlert2 = false// per errore nel caso di scheda già generata
    
    var body: some View {
        
        TabView(selection: $selection){
            
            NavigationView{
                List{
                    ForEach(workoutStoreNew.workouts.sorted(by: { workout1, workout2 in
                        return workout1.creationdate.formatted() > workout2.creationdate.formatted()
                    })){workout in
                        //verificare il disclosure
                        DisclosureGroup(workout.workoutname){
                            VStack(alignment: .leading, spacing: 16) {
                                NavigationLink(destination: {WorkoutView(workout: workout)}, label: {WorkoutCell(workout: workout)})
                                
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .onDelete(perform: {indexSet in
                        deleteAction(indexSet)
                    })
     
                }
                .listStyle(.plain)
                .navigationTitle("My Workouts").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button(action: {
                        standardWorkout()
                    }, label: {Image(systemName:"dumbbell.fill")}),
                    trailing:
                        Button(action: {
                            workoutStoreNew.addWorkout(Workout(id: workoutStoreNew.workouts.count, workoutname: "Workout \(workoutStoreNew.workouts.count+1)", exercises: [], creationdate: Date.now, date: [],exerciseTime:DateComponents()))
                            showingAddView.toggle()
                        }, label: {Image(systemName: "plus")}).alert(isPresented: $showAlert1, content: {
                            Alert(title: Text("Dati mancanti"), message: Text("E' necessario conoscere  altezza,peso,sesso e livello di allenamento per generare una scheda di allenamento adatta a te!\nCompila i dati nella sezione profilo."), dismissButton: .default(Text("OK")))
                               })
                 )
                                .alert(isPresented: $showAlert2, content: {
                                    Alert(title: Text("Attenzione"), message: Text("Hai già generato la tua scheda standard!\nPer crearne una nuova devi eliminare la precedente!"), dismissButton: .default(Text("OK")))
                
                                })

               
                
                
                
            }.sheet(isPresented: $showingAddView, content: {AddView(trainingTime: DateComponents())})
                .environmentObject(workoutStoreNew).environmentObject(profile)
                .tabItem{
                    Label("Workouts", systemImage: "dumbbell.fill")
                    
                }
                .tag(0)
            ExecutionView()
                .tabItem{
                    Label("Executions", systemImage: "figure.strengthtraining.traditional")
                }.tag(1)
                .tabItem{
                    Label("Profile",systemImage: "person.fill")
                }.tag(2)
            ProfileView().environmentObject(profile)
                .tabItem{
                    Label("Profile",systemImage: "person.fill")
                }.tag(2)
        }.accentColor(.green)
        
    }
    
    func deleteAction(_ index: IndexSet) {
        workoutStoreNew.workouts.remove(atOffsets: index)
    }
    
    
    func standardWorkout(){

            for workout in workoutStoreNew.workouts {
                        if(workout.workoutname == "Standard Workout"){
                            showAlert2=true
                            return;
                        }
                    }
        if (profile.altezza.isEmpty || (profile.peso.isEmpty || (profile.peso.sorted(by: >).first?.value.isEmpty ?? true))) {//ordino il dizionario su date e vedo se il primo valore è vuoto.
                showAlert1=true
                return;
            }
            workoutStoreNew.addStandard(profile: profile)
        
        }
   
    }

    
    
    
    struct WorkoutCell: View{
        let workout: Workout
        var count = 0
        var body: some View{
            var workoutPart =
            control(exercises: workout.exercises)
            HStack{
                //            List{
                //                ForEach(Array(workoutPart.keys),id: \.self){
                //                    item in
                //                    Text(item + ": \(workoutPart[item])")
                //                }
                //            }
                VStack{
                    ForEach(Array(workoutPart.keys),id: \.self){
                        item in
                        HStack {
                            Text(item + ":")
                            Spacer()
                            Text("\(workoutPart[item]!) ex.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }.frame(height: 60.0)
            
        }
        
    }
    
    func control(exercises: [Exercise]) -> [String: Int]{
        var workoutPart = [String: Int]()
        for exercise in exercises {
            if let count = workoutPart[exercise.exercisestat.bodypart.rawValue]{
                workoutPart[exercise.exercisestat.bodypart.rawValue] = count + 1
                
            }else{
                workoutPart[exercise.exercisestat.bodypart.rawValue] = 1
            }
        }
        
        return workoutPart
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(Profilo())
        }
    }

