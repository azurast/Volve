//
//  StarSignCategory.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import Foundation

enum StarSign: String, CaseIterable, Identifiable {
    case aries = "Aries♈︎";
    case taurus = "Taurus♉︎";
    case gemini = "Gemini♊︎";
    case cancer = "Cancer♋︎";
    case leo = "Leo♌︎";
    case virgo = "Virgo♍︎";
    case libra = "Libra♎︎";
    case scorpio = "Scorpio♏︎";
    case sagittarius = "Sagittarius♐︎";
    case capricorn = "Capricorn♑︎";
    case aquarius = "Aquarius♒︎";
    case pisces = "Pisces♓︎";
    
    var id: String { self.rawValue }
}

extension Date {
    
    func StarSign() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.dateComponents([.day, .month], from: self)
        let day = date.value(for: .day)!
        let month = date.value(for: .month)!
        switch month {
        case 1:
            if day < 20 {
                return Volve.StarSign.capricorn.rawValue
            } else {
                return Volve.StarSign.aquarius.rawValue
            }
        case 2:
            if day < 19 {
                return Volve.StarSign.aquarius.rawValue
            } else {
                return Volve.StarSign.pisces.rawValue
            }
        case 3:
            if day < 21 {
                return Volve.StarSign.pisces.rawValue
            } else {
                return Volve.StarSign.aries.rawValue
            }
        case 4:
            if day < 20 {
                return Volve.StarSign.aries.rawValue
            } else {
                return Volve.StarSign.taurus.rawValue
            }
        case 5:
            if day < 21 {
                return Volve.StarSign.taurus.rawValue
            } else {
                return Volve.StarSign.gemini.rawValue
            }
        case 6:
            if day < 21 {
                return Volve.StarSign.gemini.rawValue
            } else {
                return Volve.StarSign.cancer.rawValue
            }
        case 7:
            if day < 23 {
                return Volve.StarSign.cancer.rawValue
            } else {
                return Volve.StarSign.leo.rawValue
            }
        case 8:
            if day < 23 {
                return Volve.StarSign.leo.rawValue
            } else {
                return Volve.StarSign.virgo.rawValue
            }
        case 9:
            if day < 23 {
                return Volve.StarSign.virgo.rawValue
            } else {
                return Volve.StarSign.libra.rawValue
            }
        case 10:
            if day < 23 {
                return Volve.StarSign.libra.rawValue
            } else {
                return Volve.StarSign.scorpio.rawValue
            }
        case 11:
            if day < 22 {
                return Volve.StarSign.scorpio.rawValue
            } else {
                return Volve.StarSign.sagittarius.rawValue
            }
        case 12:
            if day < 22 {
                return Volve.StarSign.sagittarius.rawValue
            } else {
                return Volve.StarSign.capricorn.rawValue
            }
        default :
            return "No Star Sign Found"
    }
    }
    
}
