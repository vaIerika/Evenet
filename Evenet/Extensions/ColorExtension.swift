//
//  ColorExtension.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

extension UIColor {
    public class var pearl: UIColor {
        UIColor(red: 239/255, green: 245/255, blue: 255/255, alpha: 1)
    }
}

extension Color {
    static let pearl = Color(red: 239/255, green: 245/255, blue: 255/255)
    static let charcoal = Color(red: 57/255, green: 62/255, blue: 70/255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct ColorExtension_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Circle()
                .foregroundColor(.pearl)
            Circle()
                .foregroundColor(.charcoal)
        }
        .frame(height: 50)
        .padding(40)
        .previewLayout(.fixed(width: 230, height: 120))
    }
}
