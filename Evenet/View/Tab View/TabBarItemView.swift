//
//  TabBarItemView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct TabBarItemView: View {
    var tabView: TabItem
    @Binding var selectedTabView: TabItem
    
    var isSelected: Bool { selectedTabView == tabView }
    
    var imageName: String {
        switch tabView {
        case .contacted: return "person.crop.circle.fill.badge.checkmark"
        case .contacts: return "person.2"
        case .profile: return "person.crop.square"
        case .uncontacted: return "person.crop.circle.fill.badge.exclam"
        }
    }
    
    var body: some View {
        Button(action: {
            selectedTabView = tabView
        }) {
            TabViewButton(imageName: imageName, isSelected: isSelected)
        }
    }
    
    struct TabViewButton: View {
        var imageName: String
        var isSelected: Bool
        
        var body: some View {
            Image(systemName: imageName)
                .foregroundColor(.pink)
                .font(.headline)
                .padding(15)
                .background(
                    NeumorphismButtonBackground(shape: Circle(), isHightlighted: isSelected)
                )
        }
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 30) {
            TabBarItemView(tabView: .contacts, selectedTabView: .constant(TabItem.contacts))
            TabBarItemView(tabView: .profile, selectedTabView: .constant(TabItem.contacts))
        }
    }
}
