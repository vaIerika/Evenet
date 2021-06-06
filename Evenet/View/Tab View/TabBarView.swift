//
//  TabBarView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedItem: TabItem
        
    var body: some View {
        HStack(spacing: 20) {
            ForEach(TabItem.allCases, id: \.self) { item in
                TabBarItemView(tabView: item, selectedTabView: $selectedItem)
            }
        }
        .padding(.top, 11)
        .padding(.bottom, 22)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}

enum TabItem: CaseIterable {
    case contacts, contacted, uncontacted, profile
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedItem: .constant(.contacts))
    }
}
