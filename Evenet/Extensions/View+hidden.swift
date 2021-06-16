//
//  View+hidden.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/06/2021.
//

import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide { hidden() }
        else { self }
    }
}
