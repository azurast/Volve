//
//  NotificationManager.swift
//  Volve
//
//  Created by Azura on 19/08/21.
//

import Foundation
import UserNotifications
import CoreData

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, _ in
                    self.fetchNotificationSettings()
                    completion(granted)
            }
    }

    func fetchNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings(){
            settings in
                DispatchQueue.main.async {
                    self.settings = settings
                }
        }
    }
    
    func scheduleNotifications(person: PersonEntity) {
        let content = UNMutableNotificationContent()
        
        content.title = "\(String(describing: person.firstName))'s Birthday"
        content.body = "Gentle reminder that \(String(describing: person.firstName))'s birthday is in 3 days"
        
        var trigger: UNNotificationTrigger?
        
        let reminderComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: person.birthday!)
        
        trigger = UNCalendarNotificationTrigger(dateMatching: reminderComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    
    }
    
}
