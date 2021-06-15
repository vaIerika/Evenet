//
//  ProfileTextField.swift
//  Evenet
//
//  Created by Valerie Abelovska on 06/06/2021.
//

import SwiftUI

struct ProfileTextField: View {
    @Binding var text: String
    var description: String
    var contentType:  UITextContentType?
    var size: Size = .normal
    
    private var sizedFont: Font {
        switch size {
        case .normal: return .custom("Helvetica", size: 14)
        case .medium: return .custom("Helvetica-bold", size: 14)
        case .large: return .custom("Helvetica-bold", size: 20)
        }
    }
    
    private var imageName: String {
        let defaultImage = "square.and.pencil"
        if let contentType = contentType {
            switch contentType {
            case .name: return "person"
            case .emailAddress: return "envelope"
            case .telephoneNumber: return "phone"
            default: return defaultImage
            }
            
        }
        return defaultImage
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: imageName)
            TextField("Enter your \(description.lowercased())", text: $text)
                .font(sizedFont)
        }
        
//        VStack(alignment: .leading){
//            Text(description)
//                .font(.custom("Helvetica-light", size: 14))
//                .opacity(0.5)
//            TextField("Enter your \(description.lowercased())", text: $text)
//                .font(sizedFont)
//        }
        .foregroundColor(.charcoal)
        .padding(.top, 15)
    }
    
    enum Size { case normal, medium, large }
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
            ProfileTextField(text: .constant(""), description: "Name", contentType: .name, size: .large)
            ProfileTextField(text: .constant(""), description: "Email", contentType: .emailAddress)
            ProfileTextField(text: .constant(""), description: "Phone number", contentType: .telephoneNumber)
            ProfileTextField(text: .constant(""), description: "Address", contentType: .addressCity)
//            ProfileMediumTextField(description: "Email", contentType: .emailAddress, text: .constant(""))
//            ProfileLargeTextField(description: "Address", contentType: .addressCity, text: .constant(""))
        }.padding()
    }
}
