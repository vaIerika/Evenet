//
//  QRCodeView.swift
//  Evenet
//
//  Created by Valerie Abelovska on 15/06/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    var name: String
    var phoneNumber: String
    var emailAddress: String
    var workplace: String
    
    private let context = CIContext()
    private let filer = CIFilter.qrCodeGenerator()
    
    var body: some View {
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
    }
    
    private func generateQRCode(from string: String) -> UIImage {
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

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(name: "Unknown", phoneNumber: "", emailAddress: "", workplace: "")
    }
}
