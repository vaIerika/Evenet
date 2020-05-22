//
//  CustomButtonStyle.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct CustomButtonBackground<S: Shape>: View {
    var isHightlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHightlighted {
                shape
                    .fill(Color.pearl)
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(
                                shape
                                    .fill(LinearGradient(Color.black, Color.clear))
                            )
                            .overlay(
                                shape
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(
                                        shape
                                            .fill(LinearGradient(Color.clear, Color.white))
                                    )
                            )
                    )
            } else {
                shape
                    .fill(Color.pearl)
                    .shadow(color: Color.gray.opacity(0.6), radius: 8, x: 8, y: 8)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
    }
}

struct CustomButtonBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
