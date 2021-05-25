//
//  Member.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI

struct Contact: Identifiable, Codable {
    var id: UUID
    var name: String
    var phoneNumber: String
    var emailAddress: String
    var workplace: String
    private(set) var isContacted: Bool
    var date: Date
    
    init(name: String = "Anonymous", phoneNumber: String = "", emailAddress: String = "", workplace: String = "", isContacted: Bool = false) {
        self.id = UUID()
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.workplace = workplace
        self.isContacted = isContacted
        self.date = Date()
    }
    
    mutating func toggleContacted() {
        isContacted.toggle()
    }
}
