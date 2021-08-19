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
        
        if let birthday = person.birthday {
            // Reminder Components
            let daysBefore = UserSettingsManager.shared.getReminderDays()
            
            var reminderComponents = DateComponents()
            reminderComponents.day = -daysBefore
            
            // TODO : check without taking into acount year & all other logic
            if birthday.month < Date().month {
                reminderComponents.year = Date().year - birthday.year + 1
            } else {
                if birthday.month == Date().month {
                    if birthday.day < Date().day {
                        
                    }
                } else  {
                    reminderComponents.year = Date().year - birthday.year
                }
            }
            
            // FOR DEBUG ONLY
            let reminderDate = Calendar.current.date(byAdding: reminderComponents, to: birthday)
            
            reminderComponents.day = reminderDate?.day
            reminderComponents.month = reminderDate?.month
            reminderComponents.year = reminderDate?.year
            reminderComponents.hour = 8
            reminderComponents.minute = 0
            
            dump("reminderDate is \(String(describing: reminderComponents))")
            
            trigger = UNCalendarNotificationTrigger(dateMatching: reminderComponents, repeats: true)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
}
