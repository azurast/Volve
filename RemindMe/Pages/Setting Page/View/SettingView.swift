//
//  SettingView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct SettingView: View {
    @State var isNotificationsOn : Bool = true
    @State var selectedReminder : ReminderOptions = .theday
    @State var selectedLanguage : LanguageOptions = .english
    
    var body: some View {
        Form {
            Toggle(isOn: $isNotificationsOn) {
                Text("Turn on notifications")
            }
            if isNotificationsOn {
                Picker("Reminder", selection: $selectedReminder) {
                    Text("The day").tag(ReminderOptions.theday)
                    Text("One day before").tag(ReminderOptions.oneday)
                    Text("Two days before").tag(ReminderOptions.twodays)
                    Text("Theree days before").tag(ReminderOptions.threedays)
                    Text("One week before").tag(ReminderOptions.oneweek)
                    Text("Two weeks before").tag(ReminderOptions.twoweeks)
                    Text("Three weeks before").tag(ReminderOptions.threeweeks)
                }
            }
            Picker("Language", selection: $selectedLanguage) {
                Text("English").tag(LanguageOptions.english)
                Text("Bahasa Indonesia").tag(LanguageOptions.bahasa)
            }
            Text("Test send push notifications")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
