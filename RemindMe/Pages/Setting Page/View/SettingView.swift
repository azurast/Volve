//
//  SettingView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct SettingView: View {
    @StateObject var vm : CoreDataViewModel
    @State var isNotificationsOn : Bool = UserSettingsManager.shared.getReminder()
    @State var selectedReminder : ReminderOptions = ReminderOptions(rawValue: UserSettingsManager.shared.getReminderDays()) ?? .theday
    
    var body: some View {
        Form {
            Toggle(isOn: $isNotificationsOn) {
                Text("turnOnNotifications".localized())
            }.onTapGesture {
                UserSettingsManager.shared.setReminder(isOn: !isNotificationsOn)
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
                }.onChange(of: selectedReminder, perform: {
                    value in
                        UserSettingsManager.shared.setReminderDays(daysBefore: value)
                    vm.updateReminderDate()
                })
            }
            Text("testPushNotif".localized())
        }
    }
}
