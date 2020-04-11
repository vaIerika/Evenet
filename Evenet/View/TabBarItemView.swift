//
//  TabBarItemView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct TabBarItemView: View {
    @Binding var selectedTabView: SelectedTabView
    
    let id = UUID()
    var tabView: SelectedTabView
    var icon: String
    
    func isSelected() -> Bool {
        return selectedTabView == tabView
    }
    
    var buttonPressed: some View {
        Image(systemName: self.icon)
            .foregroundColor(.pink)
            .font(.headline)
            .padding(30)
            .background(
                CustomButtonBackground(isHightlighted: true, shape: Circle())
            )
    }
    
    var buttonUnpressed: some View {
        Image(systemName: self.icon)
            .foregroundColor(.pink)
            .font(.headline)
            .padding(30)
            .background(
                CustomButtonBackground(isHightlighted: false, shape: Circle())
            )
    }
        
    var body: some View {
        
        Button(action: {
            self.selectedTabView = self.tabView
        }) {
            if isSelected() {
                buttonPressed
            } else {
                buttonUnpressed
            }
        }
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemView(selectedTabView: .constant(SelectedTabView.contacts), tabView: .contacts, icon: "person.2")
    }
}
