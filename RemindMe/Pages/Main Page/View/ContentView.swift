//
//  ContentView.swift
//  RemindMe
//
//  Created by Azura Sakan Taufik on 15/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = CoreDataViewModel()
    @State private var showModal = false
    
    var today = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(vm.savedPeople.sorted(by: { $0.daysLeft < $1.daysLeft })) { entity in
                        PersonCard(person: entity).id(entity.id)
                    }
                }
            }
            .navigationTitle("Birthdays")
            .toolbar {
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
                AddModalView(vm: vm)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
