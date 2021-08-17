//
//  DateHelper.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import Foundation

func createFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM y"
    return formatter
}
