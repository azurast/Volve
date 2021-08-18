//
//  NotificationManager.swift
//  Volve
//
//  Created by Azura on 19/08/21.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, _ in
                    // After user granted permission to send notifications, fetch the notification setting
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
    
}
