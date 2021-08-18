//
//  SettingManager.swift
//  Volve
//
//  Created by Azura on 19/08/21.
//

import Foundation

class UserSettingsManager : ObservableObject {
    static let shared = UserSettingsManager()
    @Published var userDefaults = UserDefaults.standard
    
    enum Keys : String, CaseIterable, Identifiable {
        case isFirstTime
        case isReminderOn
        
        var id: String { self.rawValue }
    }
    
    func setDefaultValues() {
        if !userDefaults.bool(forKey: Keys.isFirstTime.id) {
            userDefaults.setValue(false, forKey: Keys.isReminderOn.id)
            userDefaults.setValue(true, forKey: Keys.isFirstTime.id)
        }
    }
    
    func setReminder(isOn: Bool) {
        userDefaults.set(isOn, forKey: Keys.isReminderOn.id)
    }
    
    func getReminder() -> Bool {
        return userDefaults.bool(forKey: Keys.isReminderOn.id)
    }
}
