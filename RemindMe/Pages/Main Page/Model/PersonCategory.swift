//
//  PersonCategory.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import Foundation

enum PersonCategory: String, CaseIterable, Identifiable {
    case friends
    case family
    case work
    var id: String { self.rawValue }
    
}
