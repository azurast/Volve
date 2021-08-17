//
//  ImageModifier.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import Foundation
import SwiftUI

struct ImageModifier: ViewModifier {
    @State var width : CGFloat
    @State var height : CGFloat
    @State var edgeInsets: EdgeInsets?
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height, alignment: .leading)
            .padding(edgeInsets ?? EdgeInsets())
            .aspectRatio(contentMode: .fit)
    }
}
