//
//  SettingView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct SettingView: View {
    @State var isNotificationsOn : Bool = UserSettingsManager.shared.getReminder()
    @State var selectedReminder : ReminderOptions = .theday
    
    var body: some View {
        Form {
            Toggle(isOn: $isNotificationsOn) {
                Text("turnOnNotifications".localized())
            }.onTapGesture {
                print("Tapped")
                UserSettingsManager.shared.setReminder(isOn: isNotificationsOn)
            }
            if isNotificationsOn {
                Picker("selectedReminder".localized(), selection: $selectedReminder) {
                    Text("theDay".localized()).tag(ReminderOptions.theday)
                    Text("oneDayBefore".localized()).tag(ReminderOptions.oneday)
                    Text("twoDaysBefore".localized()).tag(ReminderOptions.twodays)
                    Text("threeDaysBefore".localized()).tag(ReminderOptions.threedays)
                    Text("oneWeekBefore".localized()).tag(ReminderOptions.oneweek)
                    Text("twoWeeksBefore".localized()).tag(ReminderOptions.twoweeks)
                    Text("threeWeeksBefore".localized()).tag(ReminderOptions.threeweeks)
                }
            }
            Text("testPushNotif".localized())
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
