//
//  ContactView.swift
//  Evenet
//
//  Created by Valerie Abelovska on 06/06/2021.
//

import SwiftUI

struct ContactView: View {
    var contact: Contact
    var filter: FilterType
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.pink)
                .opacity(contact.isContacted && filter == .all ? 1 : 0)
            
            VStack(alignment: .leading) {
                Text(contact.workplace.uppercased())
                    .font(.custom("Helvetica-light", size: 11))
                    .padding(.bottom, 5)
                
                Text(contact.name)
                    .font(.custom("Helvetica-bold", size: 15))
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 15) {
                        Text(contact.phoneNumber)
                        Text(contact.emailAddress)
                        Spacer()
                    }
                }
                .font(.custom("Helvetica", size: 13))
                .padding(.top, 10)
            }
            .foregroundColor(.charcoal)
            .padding(.vertical, 8)
        }
        .padding(.vertical, 10)
        .padding(.leading, 25)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.pearl)
        )
        .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.white.opacity(0.7), radius: 5, x: -2.5, y: -2.5)
        .padding(.horizontal)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ContactView(contact: MyContacts().people[0], filter: .contacted)
            ContactView(contact: MyContacts().people[1], filter: .uncontacted)
            ContactView(contact: MyContacts().people[2], filter: .all)
        }.padding()
    }
}
