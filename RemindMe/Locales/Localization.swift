//
//  Localization.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizeable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
