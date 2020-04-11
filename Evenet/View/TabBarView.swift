//
//  TabBarView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedItem: SelectedTabView
    
    var tabBarItems: [TabBarItemView]
    
    var body: some View {
        HStack {
            ForEach(tabBarItems, id: \.id) { item in
                HStack {
                    Spacer()
                    item
                    Spacer()
                }
            }
        }
        .padding(.top, 11)
        .padding(.bottom, 22)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedItem: .constant(.contacts), tabBarItems: [
            TabBarItemView(selectedTabView: .constant(.contacts), tabView: .contacts, icon: "person.2"),
            TabBarItemView(selectedTabView: .constant(.contacted), tabView: .contacted, icon: "person.crop.circle.fill.badge.checkmark"),
            TabBarItemView(selectedTabView: .constant(.uncontacted), tabView: .uncontacted, icon: "person.crop.circle.fill.badge.exclam"),
            TabBarItemView(selectedTabView: .constant(.profile), tabView: .profile, icon: "person.crop.square")
        ])
    }
}
