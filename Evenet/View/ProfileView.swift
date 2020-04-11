//
//  ProfileView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct ProfileLargeTextField: View {
    var description: String
    var contentType:  UITextContentType?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
                .font(.custom("Helvetica-light", size: 14))
                .foregroundColor(.primaryDark)
            TextField(description, text: $text)
                .font(.custom("Helvetica-bold", size: 20))
                .foregroundColor(.primaryDark)
        }
        .padding(.top, 15)
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
                .foregroundColor(.primaryDark)
            TextField(description, text: $text)
                .font(.custom("Helvetica-bold", size: 14))
                .foregroundColor(.primaryDark)
        }
        .padding(.top, 15)
    }
}

struct ProfileTextField: View {
    var description: String
    var contentType:  UITextContentType?
    @Binding var text: String
    
    var body: some View {
        TextField(description, text: $text)
            .font(.custom("Helvetica-light", size: 14))
            .foregroundColor(.primaryDark)
    }
}

struct ProfileView: View {
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var name = "Valerie A."
    @State private var phoneNumber = ""
    @State private var emailAddress = "valerika.hello@gmail.com"
    @State private var workplace = "🍏 Inc."
    @State private var disableEditing = true
    let context = CIContext()
    let filer = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Image(uiImage: generateQRCode(from: "\(name)\n\(phoneNumber)\n\(emailAddress)\n\(workplace)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 70, idealWidth: 120, maxWidth: 170, minHeight: 70, idealHeight: 120, maxHeight: 170)
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .frame(minWidth: 100, idealWidth: 200, maxWidth: 250, minHeight: 100, idealHeight: 200, maxHeight: 250)
                            .aspectRatio(contentMode: .fit)

                            .foregroundColor(.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 8, y: 8)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    )
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.disableEditing.toggle()
                    }) {
                        if disableEditing {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit")
                            }
                            .foregroundColor(.pink)
                            .frame(width: 80, height: 30, alignment: .trailing)
                         } else {
                            Text("Save")
                               .foregroundColor(.pink)
                               .frame(width: 80, height: 30, alignment: .trailing)
                        }
                    }
                    .offset(x: -5, y: 35)
                    .layoutPriority(1)
                }
                Group {
                    ProfileLargeTextField(description: "My name is:", contentType: .name, text: $name)
                        .padding(.bottom, 15)
                    ProfileTextField(description: "Phone number", contentType: .telephoneNumber, text: $phoneNumber)
                    ProfileTextField(description: "Email address", contentType: .emailAddress, text: $emailAddress)
                        .padding(.bottom, 17)
                    ProfileMediumTextField(description: "I work in: ", contentType: .jobTitle, text: $workplace)
                }
                .disabled(disableEditing)
                
                Spacer()
            }
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.16))
                
            .padding(.horizontal, 20)
            .background(Color.customWhite)
                
            .navigationBarTitle("My QR code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filer.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filer.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.octagon") ?? UIImage()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
