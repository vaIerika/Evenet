//
//  NeumorphismButtonBackground.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import SwiftUI

struct NeumorphismButtonBackground<S: Shape>: View {
    var shape: S
    var isHightlighted: Bool
    
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

struct NeumorphismButtonBackground_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 30) {
            Image(systemName: "person")
                .padding(10)
                .background(NeumorphismButtonBackground(shape: Circle(), isHightlighted: true))
            Image(systemName: "person")
                .padding(10)
                .background(NeumorphismButtonBackground(shape: Circle(), isHightlighted: false))
        }
    }
}
