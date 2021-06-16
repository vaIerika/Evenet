//
//  ProfileView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var name = "Valerie A."
    @State private var phoneNumber = ""
    @State private var emailAddress = "valerika.hello@gmail.com"
    @State private var workplace = "🍏 Inc."
    @State private var disableEditing = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                QRCodeView(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress, workplace: workplace)
                EditButtonView(disableEditing: $disableEditing)
                    .padding(.top)
                Group {
                    ProfileTextField(text: $name, description: "My name", contentType: .name, size: .large)
                    ProfileTextField(text: $phoneNumber, description: "Phone number", contentType: .telephoneNumber)
                    ProfileTextField(text: $emailAddress, description: "Email", contentType: .emailAddress)
                    ProfileTextField(text: $workplace, description: "Workplace", contentType: .organizationName)
                }
                .disabled(disableEditing)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .padding(.horizontal, 20)
            .navigationBarTitle("My QR code")
            .padding(.bottom, keyboard.currentHeight)
            .background(Color.pearl)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
