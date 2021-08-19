//
//  Reminder.swift
//  Volve
//
//  Created by Azura on 19/08/21.
//

import Foundation

struct Reminder: Codable {
    var timeInterval: TimeInterval?
    var birthDate: Date?
    var repeats = true
}
