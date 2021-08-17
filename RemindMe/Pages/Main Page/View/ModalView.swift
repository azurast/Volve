//
//  ModalView.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import SwiftUI

struct ModalView: View {
    @StateObject var vm : CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showAvatarOptions : Bool = false
    @State var selectedImageIndex : Int16 = 0
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var category : String = ""
    @State private var birthday = Date()
    
    var body: some View {
        
        NavigationView {
            Form {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                    HStack {
                        Spacer()
                        Image("av_\(selectedImageIndex)")
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
                TextField("firstName".localized(), text: $firstName)
                TextField("lastName".localized(), text: $lastName)
                Picker("category".localized(), selection: $category) {
                    ForEach(PersonCategory.allCases) {
                        category in Text(category.rawValue.localized())
                    }
                }
                DatePicker("dateOfBirth".localized(), selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "locale".localized()))
            }
            .navigationTitle("addABirthday".localized())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("cancel".localized())
                }),
                trailing: Button(action: {
                    vm.addPerson(firstName: firstName, lastName: lastName, birthday: birthday, category: category, photo: selectedImageIndex)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("add".localized())
                })
            )
        }
    }
}
