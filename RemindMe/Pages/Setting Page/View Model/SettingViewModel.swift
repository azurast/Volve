//
//  SettingViewModel.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import Foundation

func reminderOptionsDictionary() -> [ReminderOptions: Int]{
    let dictionary : [ReminderOptions: Int] = [
        .theday: 1,
        .twodays: 2,
        .threedays: 3,
        .oneweek: 7,
        .twoweeks: 14,
        .threeweeks: 21
    ]
    dump(dictionary)
    return dictionary
}
