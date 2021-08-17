//
//  ReminderOptions.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import Foundation

enum ReminderOptions: Int, CaseIterable, Identifiable {
    case theday = 0
    case oneday = 1
    case twodays = 2
    case threedays = 3
    case oneweek = 7
    case twoweeks = 14
    case threeweeks = 21
    
    var id: Int { self.rawValue }
}

enum LanguageOptions: String, CaseIterable, Identifiable {
    case english
    case bahasa
    
    var id: String { self.rawValue }
}
