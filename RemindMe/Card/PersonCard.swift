//
//  PersonCard.swift
//  RemindMe
//
//  Created by Azura Sakan Taufik on 15/08/21.
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

func createFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM y"
    return formatter
}

struct PersonCard: View {
    @State var person : PersonEntity
    var formatter = createFormatter()
    var today = Date()
    var x : Int = Int(arc4random_uniform(6))
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image("av_\(x)")
                .resizable()
                .frame(width: 50, height: 50, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 4) {
                Text(person.firstName ?? "No Name").bold()+Text(" ")+Text(person.lastName ?? "No Name").bold()
                Text(person.category?.capitalized ?? "No Category")
                    .padding(.all, 4)
                    .font(.caption)
                    .background(Color("TransparantAccent"))
                    .foregroundColor(.accentColor)
                    .frame(height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                HStack {
                    Image(systemName: "gift.circle.fill").foregroundColor(.accentColor)
                    Text(formatter.string(from: person.birthday!)).font(.caption).foregroundColor(.accentColor)
                }
            }
            Spacer()
            VStack {
                Text(String(person.daysLeft)).foregroundColor(.accentColor).font(.callout).bold()
                Text("days left").foregroundColor(.secondary).font(.caption)
            }.padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(Color.init("Secondary"))
        .modifier(CardModifier())
        .padding(EdgeInsets(top: 4, leading: 20, bottom: 0, trailing: 20))
    }
}

struct CategoryCard: View {
    @State var categoryName : String
    var body: some View {
        ZStack {
            Button(action: {
                print("clicked")
            }, label: {
                Text(categoryName).foregroundColor(.white).bold().font(.subheadline)
            }).frame(width: 100, height: 20,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.all, 8)
        }.background(Color("AccentColor"))
        .modifier(CardModifier())
    }
}
