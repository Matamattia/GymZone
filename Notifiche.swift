//
//  Notifiche.swift
//  MyApplication
//
//  Created by Mattia De Bartolomeis on 22/04/23.
//

import Foundation
import UserNotifications

//:ObservableObject
class Notifiche{
    

    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success,error)  in
            if let error = error{
                print("ERRORE")
            } else{
                print("SUCCESSO") 
            }
        }
    }
  
    
    func scheduleNotification(date: DateComponents,nome:String,workoutName:String) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title =  "GymZone"
                if(nome != ""){
                    content.body = "\(nome) è tempo di eseguire il workout:\(workoutName)"
                }else{
                    content.body = "E' tempo di eseguire il workout:\(workoutName)"
                }
                content.sound = .default
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if error != nil {
                        print("Errore durante l'aggiunta della richiesta di notifica: \(error?.localizedDescription ?? "Errore sconosciuto")")
                    }
                }
            }
        })
    }

}

