//
//  ContentView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI

struct ContentView: View {
    init() {
        // To add background color for the Nav.Bar
        UITableView.appearance().backgroundColor = .pearl
        
        // To remove only extra separators below the list
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones
        UITableView.appearance().separatorStyle = .none
    }
    
    var contacts = MyContacts()

    @State var selectedTabView = TabItem.contacts

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    if selectedTabView == .contacts {
                        ContactsView(filter: .all)
                        ContactsView(filter: .contacted).hidden()
                        ContactsView(filter: .uncontacted).hidden()
                        ProfileView().hidden()
                    } else if selectedTabView == .contacted {
                        ContactsView(filter: .all).hidden()
                        ContactsView(filter: .contacted)
                        ContactsView(filter: .uncontacted).hidden()
                        ProfileView().hidden()
                    } else if selectedTabView == .uncontacted {
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
                
                TabBarView(selectedItem: $selectedTabView)
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
