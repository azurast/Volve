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

extension Date {

    var year: Int { Calendar.current.component(.year, from: self) }
    var month: Int { Calendar.current.component(.month, from: self) }
    var day: Int { Calendar.current.component(.day, from: self) }
    var hour: Int { Calendar.current.component(.hour, from: self) }
    var minute: Int { Calendar.current.component(.minute, from: self) }

    var isLeapYear: Bool { Calendar.current.range(of: .day, in: .year, for: self)!.count == 366 }

    // find the leap year
    static var leapYear: Int {
        var year = Date().year
        while DateComponents(calendar: .current, year: year).date?.isLeapYear == false {
            year += 1
        }
        return year
    }
}
