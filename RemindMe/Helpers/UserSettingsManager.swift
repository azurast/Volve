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
        case daysBefore
        
        var id: String { self.rawValue }
    }
    
    func setDefaultValues() {
        if !userDefaults.bool(forKey: Keys.isFirstTime.id) {
            userDefaults.setValue(false, forKey: Keys.isReminderOn.id)
            userDefaults.setValue(true, forKey: Keys.isFirstTime.id)
            userDefaults.setValue(ReminderOptions.theday, forKey: Keys.daysBefore.id)
        }
    }
    
    // MARK: - Set whether reminder is on or off
    func setReminder(isOn: Bool) {
        userDefaults.set(isOn, forKey: Keys.isReminderOn.id)
    }
    
    func getReminder() -> Bool {
        return userDefaults.bool(forKey: Keys.isReminderOn.id)
    }
    
    // MARK: - Set the number of days before to remind
    func setReminderDays(daysBefore : ReminderOptions) {
        userDefaults.setValue(daysBefore.id, forKey: Keys.daysBefore.id)
    }
}
