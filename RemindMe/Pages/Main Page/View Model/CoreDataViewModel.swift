//
//  CoreDataViewModel.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 16/08/21.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedPeople: [PersonEntity] = []
    var today = Date()
    
    init() {
        container = NSPersistentContainer(name: "Volve")
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
    
    func addPerson(firstName: String, lastName: String, birthday: Date, category: String, photo: Int16) {
        let newPerson = PersonEntity(context: container.viewContext)
        newPerson.firstName = firstName
        newPerson.lastName = lastName
        newPerson.birthday = birthday
        newPerson.category = category
        newPerson.photo = photo
        newPerson.id = UUID()
        newPerson.starSign = birthday.StarSign()
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
    
    func getStarSign(birthday : Date) {
        
    }
    
}
