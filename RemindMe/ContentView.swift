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
    var today = Date()
    
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
        let sort = NSSortDescriptor(keyPath: \PersonEntity.daysLeft, ascending: true)
        request.sortDescriptors = [sort]
        do {
            savedPeople = try container.viewContext.fetch(request)
            for people in savedPeople {
                people.setValue(getDaysLeftFromToday(from: people.birthday ?? today, until: today), forKey: "daysLeft")
            }
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
    
    func getDaysLeftFromToday(from birthDate: Date, until currentDate: Date) -> Int32 {
        let calendar = Calendar(identifier: .gregorian)
        
        let monthComp = calendar.dateComponents([.month], from: birthDate)
        let dayComp = calendar.dateComponents([.day], from: birthDate)
        
        let birthdateComponents = DateComponents(month: monthComp.month, day: dayComp.day)
       
        if let nextBirthday = Calendar.current.nextDate(after: currentDate, matching: birthdateComponents, matchingPolicy: .strict),
           let daysLeftUntilNextBirthday = Calendar.current.dateComponents([.day], from: currentDate, to: nextBirthday).day {
            // TODO : Ceiling
            print("days left \(daysLeftUntilNextBirthday)")
            return Int32(daysLeftUntilNextBirthday)
        }
        return 0
        
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
            Form {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                    HStack {
                        Spacer()
                        Image("av_1")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.accentColor)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                Picker("Category", selection: $category) {
                    ForEach(PersonCategory.allCases) {
                        category in Text(category.rawValue.capitalized)
                    }
                }
                DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
            }
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
    var today = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(vm.savedPeople.sorted(by: { $0.daysLeft < $1.daysLeft })) { entity in
                        PersonCard(person: entity)
                    }
                }
            }
            .navigationTitle("Birthdays")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image.init(systemName: "gearshape")
                    })
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image.init(systemName: "plus")
                    })
                }
            }
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
