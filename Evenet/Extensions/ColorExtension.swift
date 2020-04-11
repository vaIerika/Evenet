//
//  ColorExtension.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

extension UIColor {
    public class var whiteBG: UIColor {
        UIColor(red: 239/255, green: 245/255, blue: 255/255, alpha: 1)
    }
}

extension Color {
    static let customWhite = Color(red: 239/255, green: 245/255, blue: 255/255)
    
    static let darkStart = Color(red: 50/255, green: 60/255, blue: 65/255)
    static let darkEnd = Color(red: 25/255, green: 25/255, blue: 30/255)
    
    static let lightStart = Color(red: 60/255, green: 160/255, blue: 240/255)
    static let lightEnd = Color(red: 30/255, green: 80/255, blue: 120/255)
    
    static let primaryDark = Color(red: 57/255, green: 62/255, blue: 70/255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
