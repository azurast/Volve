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
        newPerson.reminderDate = getReminderDate(birthday: birthday)
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
        
        let birthdayComponents = calendar.dateComponents([.day, .month], from: birthDate)
        var birthdayDateComponents = DateComponents(month: birthdayComponents.month, day: birthdayComponents.day)
        let currentDateComponents = DateComponents(year: calendar.dateComponents([.year], from: currentDate).year)
       
        // MARK - If birthday is on Feb 29
        if let isLeapYear = DateComponents(calendar: .current, year: currentDateComponents.year).date?.isLeapYear {
            if !isLeapYear {
                if birthdayDateComponents.month == 2 {
                 if birthdayDateComponents.day == 29 {
                    birthdayDateComponents = DateComponents(month: 2, day: 28)
                 }
                }
            }
        }
        
        if let nextBirthday = Calendar.current.nextDate(after: currentDate, matching: birthdayDateComponents, matchingPolicy: .strict),
           let daysLeftUntilNextBirthday = Calendar.current.dateComponents([.day], from: currentDate, to: nextBirthday).day {
            // TODO : Ceiling
            print("days left \(daysLeftUntilNextBirthday)")
            return Int32(daysLeftUntilNextBirthday)
        }
        return 0
        
    }
    
    func getReminderDate(birthday: Date) -> Date {
        
        let daysBefore = UserSettingsManager.shared.getReminderDays()
        
        var reminderComponents = DateComponents()
        reminderComponents.day = -daysBefore
        
        // TODO : check without taking into acount year & all other logic
        if birthday.month < Date().month {
            reminderComponents.year = Date().year - birthday.year + 1
        } else {
            if birthday.month == Date().month {
                if birthday.day < Date().day {
                    
                }
            } else  {
                reminderComponents.year = Date().year - birthday.year
            }
        }
        
        // FOR DEBUG ONLY
        let reminderDate = Calendar.current.date(byAdding: reminderComponents, to: birthday)
        
        reminderComponents.day = reminderDate?.day
        reminderComponents.month = reminderDate?.month
        reminderComponents.year = reminderDate?.year
        reminderComponents.hour = 8
        reminderComponents.minute = 0
        
        return Calendar.current.date(from: reminderComponents) ?? Date()
    }
    
}
