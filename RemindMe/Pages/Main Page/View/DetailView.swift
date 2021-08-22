//
//  DetailView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 17/08/21.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm : CoreDataViewModel
    @StateObject var person : PersonEntity
    @State var isEditing: Bool = false
    @State var showAvatarOptions : Bool = false
    @State var selectedImageIndex : Int16 = 0
    @State var showAlert: Bool = false
    @State var showDeleteAlert: Bool = false
    
    var formatter = createFormatter()

    
    var body: some View {
        ZStack(alignment: .top) {
            if !isEditing {
//                Color(.clear).edgesIgnoringSafeArea(.all)
                VStack(spacing: 4) {
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
                    Text("Reminder set on \(formatter.string(from: person.reminderDate ?? Date()))").font(.caption)
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
                                            person.photo = Int16(i)
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
                        .datePickerStyle(DefaultDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "locale".localized()))
                }
            }
        }
        .navigationTitle(person.firstName ?? "detail".localized())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(isEditing)
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Save changes to this contact?"),
                primaryButton: .destructive(
                    Text("Yes"),
                    action: {
                        person.reminderDate = vm.getReminderDate(birthday: person.birthday ?? Date())
                        person.starSign = person.birthday?.StarSign()
                        vm.updateData(person: person)
                        isEditing = !isEditing
                    }),
                secondaryButton: .cancel())
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete this contact?"),
                primaryButton: .destructive(
                    Text("Yes"),
                    action: {
                        vm.deleteData(id: person.id!)
                        isEditing = !isEditing
                    }),
                secondaryButton: .cancel())
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if !isEditing {
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        if !isEditing {
                            Image.init(systemName: "trash")
                        } else {
                            
                        }
                    }
                    Button(action: {
                        isEditing = !isEditing
                    }, label: {
                        Image.init(systemName: "square.and.pencil")
                    })
                } else {
                    Button(action: {
                        showAlert = true
                    }, label: {
                        Text("Save")
                    })
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if isEditing {
                    Button(action: {
                        isEditing = !isEditing
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
}
