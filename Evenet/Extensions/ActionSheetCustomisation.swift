//
//  ActionSheetCustomisation.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 08/04/2020.
//

import Foundation
import SwiftUI

struct ActionSheetConfigurator: UIViewControllerRepresentable {
    var configure: (UIAlertController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActionSheetConfigurator>) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<ActionSheetConfigurator>) {
        if let actionSheet = uiViewController.presentedViewController as? UIAlertController,
        actionSheet.preferredStyle == .actionSheet {
            self.configure(actionSheet)
        }
    }
}

struct ActionSheetCustom: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(ActionSheetConfigurator { action in
                // change the text color of Action Sheet text 
                action.view.tintColor = UIColor.systemPink
            })
    }
}
