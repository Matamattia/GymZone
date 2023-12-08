
import SwiftUI
import UserNotifications




struct ProfileView: View {
    @EnvironmentObject var profile:Profilo
    @State var nManager = Notifiche()
    @State var permesso = false
    @State var showChart = false
    @State private var newWeight = ""
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Informazioni personali").foregroundColor(.green)
                    //.font(.title3)
                        // .frame(maxWidth: .infinity)
                ) {

                    HStack {
                        Text("Nome")
                            .foregroundColor(Color.black)
                        TextField("", text: $profile.nome)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                           // .cornerRadius(10)
                           
                    }
                    HStack {
                        Text("Cognome:")
                        // .font(.headline)
                            .foregroundColor(.black)
                        TextField("", text: $profile.cognome)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                           // .cornerRadius(10)
                           
                    }
                    DatePicker("Data di nascita", selection: $profile.dataNascita, displayedComponents: .date).foregroundColor(.black)
                    //.font(.headline)
                    HStack{
                        Text("Sesso:").foregroundColor(.black)
                        Picker("", selection: $profile.sesso, content: {
                            Text("Maschio").tag(Sesso.maschio)
                            Text("Femmina").tag(Sesso.femmina)
                        }).pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                    }
                    HStack{
                        Text("Livello: ").foregroundColor(.black)
                        Picker("", selection: $profile.livello, content: {
                            Text("Principiante").tag(Livello.principiante)
                            Text("Intermedio").tag(Livello.intermedio)
                            Text("Esperto").tag(Livello.esperto)
                        }).pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                        
                        
                    }
                    
                    
                    
                    
                }.onTapGesture {
                    dismissKeyboard()
                }
                
                
                Section(header: Text("Misure antropometriche").foregroundColor(.green)
                    //.font(.title3)
                        //.frame(maxWidth: .infinity)
                ) {
                 
                        HStack {
                           /*Image("altezza").resizable().frame(width: 28, height: 28)*/
                            Text("Altezza:")
                                .foregroundColor(.black)
                            TextField("", text: $profile.altezza)
                                .foregroundColor(Color.gray)
                                .font(Font.system(size: 16, weight: .medium))
                                .textContentType(.name)
                                .autocapitalization(.words)
                                .keyboardType(.decimalPad)
                              //  .cornerRadius(10)
                            Text("cm").foregroundColor(.gray)
                        }.onTapGesture {
                            dismissKeyboard()
                        }
                        
                        HStack {
                            Image("bilancia").resizable().frame(width: 28, height: 28)
                            
                            Text("Peso:")
                                .foregroundColor(.black)
                            TextField("", text: $newWeight, onCommit: {
                                if !newWeight.isEmpty {
                                    profile.peso[Date.now] = newWeight
                                }
                            })
                            
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            // .keyboardType(.decimalPad) vedi se risolvi
                            //.cornerRadius(10)
                            Text("kg").foregroundColor(.gray)
                            Button(action: {showChart = true}, label:  {Image(systemName: "chart.xyaxis.line")} )
                        }
                        
                    


                }
                
                Section(header: Text("Circonferenze").foregroundColor(.green))//.font(.title3)
                {
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Collo:")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.collo)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Spalle:")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.spalle)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Bicipite:")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.bicipite)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                        
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Tricipite:")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.tricipite)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                        
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Avambraccio")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.avambracci)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                        
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Polpaccio:")
                            .foregroundColor(.black)
                        TextField("", text: $profile.misure.polpacci)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                        Text("cm").foregroundColor(.gray)
                        
                    }
                }.onTapGesture {
                    dismissKeyboard()
                }
            
                Section(header: Text("Notifiche").foregroundColor(.green)) {
                    Toggle("Abilita notifiche", isOn: $permesso).foregroundColor(.black)
                        .onChange(of: permesso) { permesso in
                            if permesso {
                                nManager.requestAuthorization()
                            } else {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                            }
                        }
                }
                        
               
            
            }.navigationTitle("Profilo")
            
            
        }.fullScreenCover(isPresented: $showChart, content:{ ChartView().environmentObject(profile)})
      
    }
 
}

    
    
    

    
func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil,for: nil)
}
    
struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
                .environmentObject(Profilo())
        }
}
    










