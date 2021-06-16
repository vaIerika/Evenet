//
//  BarButtonView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/06/2021.
//

import SwiftUI

struct BarButtonView: View {
    var text: String = ""
    var systemImage: String = ""
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if !text.isEmpty {
                    Text(text)
                        .frame(width: 80, height: 80, alignment: .leading)
                }
                if !systemImage.isEmpty {
                    Image(systemName: systemImage)
                        .frame(width: 80, height: 80, alignment: .trailing)
                }
            }
            .foregroundColor(.pink)
            .contentShape(Rectangle())
        }
    }
}

struct BarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BarButtonView(text: "Sort") { }
            BarButtonView(systemImage: "qrcode") { }
        }
    }
}
