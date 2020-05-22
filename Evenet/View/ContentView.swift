//
//  ContentView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI

enum SelectedTabView {
    case contacts, contacted, uncontacted, profile
}

struct ContentView: View {
    init() {
        // To add background color for the Nav.Bar
        UITableView.appearance().backgroundColor = .pearl
        
        // To remove only extra separators below the list
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones
        UITableView.appearance().separatorStyle = .none
    }
    
    @State var selectedTabView = SelectedTabView.contacts
    var contacts = Contacts()
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    if self.selectedTabView == .contacts {
                        ContactsView(filter: .all)
                        ContactsView(filter: .contacted).hidden()
                        ContactsView(filter: .uncontacted).hidden()
                        ProfileView().hidden()
                    } else if self.selectedTabView == .contacted {
                        ContactsView(filter: .all).hidden()
                        ContactsView(filter: .contacted)
                        ContactsView(filter: .uncontacted).hidden()
                        ProfileView().hidden()
                    } else if self.selectedTabView == .uncontacted {
                        ContactsView(filter: .all).hidden()
                        ContactsView(filter: .contacted).hidden()
                        ContactsView(filter: .uncontacted)
                        ProfileView().hidden()
                    } else {
                        ContactsView(filter: .all).hidden()
                        ContactsView(filter: .contacted).hidden()
                        ContactsView(filter: .uncontacted).hidden()
                        ProfileView()
                    }
                }
                
                TabBarView(
                    selectedItem: self.$selectedTabView, tabBarItems: [
                        TabBarItemView(selectedTabView: self.$selectedTabView, tabView: .contacts, icon: "person.2"),
                        TabBarItemView(selectedTabView: self.$selectedTabView, tabView: .contacted, icon: "person.crop.circle.fill.badge.checkmark"),
                        TabBarItemView(selectedTabView: self.$selectedTabView, tabView: .uncontacted, icon: "person.crop.circle.fill.badge.exclam"),
                        TabBarItemView(selectedTabView: self.$selectedTabView, tabView: .profile, icon: "person.crop.square")
                    ]
                )
                .padding(.top, geometry.safeAreaInsets.bottom / 2)
                .padding(.bottom, geometry.safeAreaInsets.bottom / 2)
                .background(Color.pearl)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .environmentObject(contacts)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
