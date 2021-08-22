//
//  DetailView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct DetailView: View {
    @StateObject var person : PersonEntity
    @State var isEditing: Bool = false
    @State var showAvatarOptions : Bool = false
    @State var selectedImageIndex : Int16 = 0
    
    var formatter = createFormatter()
    
    var body: some View {
        NavigationView {
            if !isEditing {
                ZStack(alignment: .top) {
                    Color(.clear).edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("av_\(person.photo)")
                           .resizable()
                           .modifier(ImageModifier(width: 100, height: 100, edgeInsets: EdgeInsets(top: 8, leading: 0, bottom: 4, trailing: 0)))
                        Text(person.firstName ?? "No First Name Found").bold()+Text(" ")+Text(person.lastName ?? "No Last Name Found").bold()
                        Text(formatter.string(from: person.birthday ?? Date()))
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
                    }
                }
            } else {
                Form {
                    VStack(alignment: .center, spacing: 16) {
                        HStack {
                            Spacer()
                            Image("av_\(person.photo)")
                                .resizable()
                                .modifier(ImageModifier(width: 100, height: 100, edgeInsets: EdgeInsets(top: 8, leading: 0, bottom: 4, trailing: 0)))
                            Spacer()
                        }
                        Button(action: { showAvatarOptions = !showAvatarOptions }, label: {
                            Text("changeAvatar".localized())
                                .font(.caption)
                                .bold()
                                .foregroundColor(.accentColor)
                        }).padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    }
                    if showAvatarOptions {
                        ScrollView(.horizontal) {
                            HStack {
                                // TODO : GET LENGTH BASED ON XCASSET
                                ForEach(0..<7){ i in
                                    Image("av_\(i)")
                                        .resizable()
                                        .modifier(ImageModifier(width: 50, height: 50, edgeInsets: EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)))
                                        .onTapGesture {
                                            selectedImageIndex = Int16(i)
                                        }
                                }
                            }
                        }
                    }
                    TextField("firstName".localized(), text: $person.firstName.bound)
                    TextField("lastName".localized(), text: $person.lastName.bound)
                    Picker("category".localized(), selection: $person.category.bound) {
                        ForEach(PersonCategory.allCases) {
                            category in Text(category.rawValue.localized())
                        }
                    }
                    DatePicker("dateOfBirth".localized(), selection: $person.birthday.bound, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "locale".localized()))
                }
            }
        }.navigationTitle(person.firstName ?? "detail".localized())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Button(action: {}) {
                        if !isEditing {
                            Image.init(systemName: "trash")
                        } else {
                            
                        }
                    }
                })
                Button(action: {
                    isEditing = !isEditing
                }, label: {
                    Button(action: {}) {
                        if !isEditing {
                            Image.init(systemName: "square.and.pencil")
                        } else {
                            Text("Save")
                        }
                    }
                })
            }
        }
    }
}
