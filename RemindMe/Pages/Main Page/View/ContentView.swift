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
    @State private var showDetail = false
    @State private var showSetting = false
    
    var today = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.savedPeople.sorted(by: { $0.daysLeft < $1.daysLeft })) { entity in
                        NavigationLink(destination: DetailView(person: entity)) {
                            PersonCard(person: entity).id(entity.id)
                        }
                    }
                }
            }
            .navigationTitle("birthdays".localized())
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        NotificationManager.shared.requestAuthorization {
                            granted in
                            if granted {
                                showSetting = true
                                print("this block runs")
                            }
                        }
                    }, label: {Image.init(systemName: "gearshape")})
                    .overlay(
                        NavigationLink(destination: SettingView(), isActive: $showSetting) { EmptyView()
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
