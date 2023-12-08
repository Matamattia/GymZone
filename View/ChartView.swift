//
//  ChartView.swift
//  MyApplication
//
//  Created by Mattia De Bartolomeis on 26/04/23.
//
//
import SwiftUI
import Charts
import SwiftUICharts



//struct ChartView: View {
//    @EnvironmentObject var profile : Profilo
//    @Environment(\.dismiss) private var dismiss
//    var body: some View {
//        NavigationView {
//            VStack{
//                HStack{
//                    Text("Ecco un grafico che mostra l'andamento del tuo peso nel tempo.")
//                }.padding()
//                VStack{
//
//                    Chart(Array(profile.peso.keys.sorted()), id: \.self) { index in
//                        LineMark(x: .value("Data", index),
//                                 y: .value("Peso",profile.peso[index]  ?? "")).foregroundStyle(by: .value("Peso", "Peso"))
//                    }.frame(width: 330,height: 180)
//                        .chartPlotStyle{plotContent in
//                            plotContent
//                                .border(.green,width: 1)
//                                .background(.green.opacity(0.1))
//                        }
//                        .chartYAxis(.hidden)
//                    //.chartYScale(domain: 88...91)
//                }.navigationTitle("Grafico peso")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationBarItems(leading: Button(action: {dismiss()}, label:{Image(systemName:"chevron.backward");Text("Indietro")})).accentColor(.green)
//            }
//        }
//
//    }
//}
//
//
//
//
//
//
//

//
//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartViesw()
//        .environmentObject(Profilo())
//    }
//}



//FUNZIONANTE
//struct ChartView: View {
//    @EnvironmentObject var profile : Profilo
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        NavigationView {
//            VStack{
//                HStack{
//                    Text("Andamento del tuo peso nel tempo.") .font(.title2)
//                        .bold()
//                        .padding(.leading, 20)
//                }.padding()
//                VStack{
//
//                    Chart(Array(profile.peso.keys.sorted()), id: \.self) { index in
//                        LineMark(x: .value("Data", index,unit:.second),
//                                 y: .value("Peso", Double(profile.peso[index] ?? "") ?? 0.0)).foregroundStyle(by: .value("Peso", "Peso"))
//                    }.frame(height: 180).padding()
//                        .chartPlotStyle{plotContent in
//                            plotContent
//                                .border(.black,width: 1)
//                                //.background(.green.opacity(0.1))
//                        }
//                        .chartYScale(domain: 10...150)
//                }.navigationTitle("Grafico peso")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationBarItems(leading: Button(action: {dismiss()}, label:{Image(systemName:"chevron.backward");Text("Indietro")})).accentColor(.green)
//            }
//        }
//    }
//}



struct ChartView: View {
    @EnvironmentObject var profile : Profilo
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Text("Andamento del peso nel tempo")
                            .font(.title2)
                            .bold()
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack{
                        Chart(Array(profile.peso.keys.sorted()), id: \.self) { index in
                            LineMark(x: .value("Data", index,unit:.second),
                                     y: .value("Peso", Double(profile.peso[index] ?? "") ?? 0.0))
                            .foregroundStyle(Color.green.gradient)
                        }
                        .chartPlotStyle{plotContent in
                            plotContent
                                .border(Color(UIColor.systemGray4), width: 1)
                                .background(Color.white)
                        }
                        .frame(height: 300)
                        .padding()
                        .chartYScale(domain:20...130)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
                    
                    Spacer()
                }
                .navigationBarTitle("Grafico peso", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {dismiss()}, label:{
                    Image(systemName:"arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                    
                    Text("Indietro")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.leading, 5)
                }))
            }
        }
    }
}
