//
//  ProfileTextField.swift
//  Evenet
//
//  Created by Valerie Abelovska on 06/06/2021.
//

import SwiftUI

struct ProfileTextField: View {
    var description: String
    var contentType:  UITextContentType?
    @Binding var text: String
    
    var body: some View {
        TextField(description, text: $text)
            .font(.custom("Helvetica-light", size: 14))
            .foregroundColor(.charcoal)
    }
}

struct ProfileMediumTextField: View {
    var description: String
    var contentType:  UITextContentType?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
                .font(.custom("Helvetica-light", size: 14))
                .foregroundColor(.charcoal)
            TextField(description, text: $text)
                .font(.custom("Helvetica-bold", size: 14))
                .foregroundColor(.charcoal)
        }
        .padding(.top, 15)
    }
}

struct ProfileLargeTextField: View {
    var description: String
    var contentType:  UITextContentType?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
                .font(.custom("Helvetica-light", size: 14))
                .foregroundColor(.charcoal)
            TextField(description, text: $text)
                .font(.custom("Helvetica-bold", size: 20))
                .foregroundColor(.charcoal)
        }
        .padding(.top, 15)
    }
}


struct ProfileTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProfileTextField(description: "Name", text: .constant(""))
            ProfileMediumTextField(description: "Email", contentType: .emailAddress, text: .constant(""))
            ProfileLargeTextField(description: "Address", contentType: .addressCity, text: .constant(""))
        }
    }
}
