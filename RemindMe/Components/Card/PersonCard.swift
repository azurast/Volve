//
//  PersonCard.swift
//  RemindMe
//
//  Created by Azura Sakan Taufik on 15/08/21.
//

import Foundation
import SwiftUI

struct PersonCard: View {
    @State var person : PersonEntity
    var formatter = createFormatter()
    var today = Date()
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image("av_\(person.photo)")
                .resizable()
                .modifier(
                    ImageModifier(
                        width: 50,
                        height: 50,
                        edgeInsets: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
                ))
            VStack(alignment: .leading, spacing: 4) {
                Text(person.firstName ?? "No Name").bold()+Text(" ")+Text(person.lastName ?? "No Name").bold()
                HStack {
                    Text(person.category?.capitalized ?? "No Category")
                        .padding(.all, 8)
                        .font(.caption)
                        .background(Color("TransparantAccent"))
                        .foregroundColor(.accentColor)
                        .frame(height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                    Text(person.starSign?.capitalized ?? "No Category")
                        .padding(.all, 8)
                        .font(.caption)
                        .background(Color("TransparantSecondary"))
                        .foregroundColor(.secondary)
                        .frame(height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                }
                HStack {
                    Image(systemName: "gift.circle.fill").foregroundColor(.accentColor)
                    Text(formatter.string(from: person.birthday!)).font(.caption).foregroundColor(.accentColor)
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Spacer()
            VStack {
                Text(String(person.daysLeft)).foregroundColor(.accentColor).font(.callout).bold()
                Text("days left").foregroundColor(.secondary).font(.caption)
            }.padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(Color.init("Secondary"))
        .modifier(CardModifier())
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}
