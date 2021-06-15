//
//  EditButtonView.swift
//  Evenet
//
//  Created by Valerie Abelovska on 15/06/2021.
//

import SwiftUI

struct EditButtonView: View {
    @Binding var disableEditing: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    disableEditing.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "pencil")
                        .opacity(disableEditing ? 1 : 0)
                    Text(disableEditing ? "Edit" : "Save")
                        .animation(.none)
                }
                .frame(width: 100, height: 30)
            }
            .foregroundColor(disableEditing ? .pink : .blue)
            .layoutPriority(1)
        }
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EditButtonView(disableEditing: .constant(true))
            EditButtonView(disableEditing: .constant(false))
        }
    }
}
