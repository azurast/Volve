//
//  CardModifier.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import Foundation
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 0)
    }
}
