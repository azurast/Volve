//
//  DetailView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct DetailView: View {
    @State var person : PersonEntity
        
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    NotificationManager.shared.scheduleNotifications(person: person)
                }) {
                    Text("Check Reminder Date")
                }
                if let reminderDate = person.reminderDate {
                    Text("Reminder set on \(reminderDate.toString)")
                }
            }
        }.navigationTitle(person.firstName ?? "detail".localized())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Button(action: {}, label: {Image.init(systemName: "trash")})
                })
                Button(action: {
                    
                }, label: {
                    Button(action: {}, label: {Image.init(systemName: "square.and.pencil")})
                })
            }
        }
    }
}
