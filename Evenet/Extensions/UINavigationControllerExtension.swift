//
//  UINavigationControllerExtension.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 06/04/2020.
//

import Foundation
import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
      
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .pearl
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .pearl
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .pearl
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}
