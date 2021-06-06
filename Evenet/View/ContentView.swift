//
//  ContentView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI

struct ContentView: View {
    var contacts = MyContacts()

    @State var selectedTabView = TabItem.contacts

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    ContactsView(filter: .all)
                        .hidden(selectedTabView != .contacts)
                    ContactsView(filter: .contacted)
                        .hidden(selectedTabView != .contacted)
                    ContactsView(filter: .uncontacted)
                        .hidden(selectedTabView != .uncontacted)
                    ProfileView()
                        .hidden(selectedTabView != .profile)
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
