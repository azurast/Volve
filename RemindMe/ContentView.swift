//
//  ContentView.swift
//  RemindMe
//
//  Created by Azura Sakan Taufik on 15/08/21.
//

import SwiftUI
import CoreData

enum PersonCategory: String, CaseIterable, Identifiable {
    case friends
    case family
    case work
    var id: String { self.rawValue }
    
}

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedPeople: [PersonEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "RemindMeContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        fetchPeople()
    }
    
    func fetchPeople() {
        let request = NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
        do {
            savedPeople = try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING CORE DATA REQUEST. \(error)")
        }
        
    }
    
    func addPerson(firstName: String, lastName: String, birthday: Date, category: String) {
        let newPerson = PersonEntity(context: container.viewContext)
        newPerson.firstName = firstName
        newPerson.lastName = lastName
        newPerson.birthday = birthday
        newPerson.category = category
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPeople()
        } catch let error {
            print("ERROR SAVING TO CORE DATA. \(error)")
        }
    }
    
}

struct ModalView: View {
    @StateObject var vm : CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var category : String = ""
    @State private var birthday = Date()
    
    var body: some View {
        NavigationView {
//            VStack(alignment: .center) {
//                Image("av_1")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
//                    .aspectRatio(contentMode: .fit)
//            }
            VStack(alignment: .leading, spacing: 8) {
                Text("First Name")
                    .bold()
                TextField("First Name", text: $firstName)
                Text("Last Name")
                    .bold()
                TextField("Last Name", text: $lastName)
                Text("Category")
                    .bold()
                HStack {
                    ForEach(PersonCategory.allCases) {
                        category in CategoryCard(categoryName: category.rawValue.capitalized)
                    }
                }
//                Picker("Category", selection: $category) {
//                    ForEach(PersonCategory.allCases) {
//                        category in Text(category.rawValue.capitalized)
//                    }
//                }
                Text("Birthday")
                    .bold()
                DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(DefaultDatePickerStyle())
                
            }
            .padding(20)
            .navigationTitle("Add a Birthday")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    vm.addPerson(firstName: firstName, lastName: lastName, birthday: birthday, category: category)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Add")
                })
            )
        }
    }
}

struct ContentView: View {
    @ObservedObject var vm = CoreDataViewModel()
    @State private var showModal = false
    @State var firstName : String
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(vm.savedPeople) { entity in
                        PersonCard(person: entity)
                    }
                }
            }
            .navigationTitle("Birthdays")
            .navigationBarItems(trailing: Button(action: {
                showModal.toggle()
            }, label: {
                Image.init(systemName: "plus")
            }))
            .sheet(isPresented: $showModal, content: {
                ModalView(vm: vm)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(firstName: "")
            ContentView(firstName: "")
        }
    }
}
