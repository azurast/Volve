//
//  RemindMeApp.swift
//  RemindMe
//
//  Created by Azura Sakan Taufik on 15/08/21.
//

import SwiftUI

@main
struct RemindMeApp: App {
    var body: some Scene {
        
        WindowGroup {
            ContentView().onAppear(){
                UserSettingsManager.shared.setDefaultValues()
            }
        }
    }
}
