//
//  Member.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import Foundation
import SwiftUI

class Contact: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var phoneNumber = ""
    var emailAddress = ""
    var workplace = ""
    fileprivate(set) var isContacted = false
    var date = Date()
}

class Contacts: ObservableObject {
    @Published private(set) var people: [Contact]
    static let saveKey = "ContactsEvenet"
    
    init() {
        // example data for preview
        let contact1 = Contact()
        contact1.name = "Vanessa Wood"
        contact1.phoneNumber = "+421 427 001 862"
        contact1.emailAddress = "vanesood@gmail.com"
        contact1.workplace = "Harris, Baker and Harrison"
        let contact2 = Contact()
        contact2.name = "Kimberly James"
        contact2.phoneNumber = "+421 656 923 217"
        contact2.emailAddress = "kimbemes@gmail.com"
        contact2.workplace = "Matthews and Sons"
        contact2.isContacted = true
        let contact3 = Contact()
        contact3.name = "Leah Martin"
        contact3.phoneNumber = "+421 045 837 608"
        contact3.emailAddress = "leahmartin@gmail.com"
        contact3.workplace = "Davies-Cox"
        let contact4 = Contact()
        contact4.name = "Michael Hall"
        contact4.phoneNumber = "+421 040 036 303"
        contact4.emailAddress = "michaell@gmail.com"
        contact4.workplace = "Matthews PLC"
        contact4.isContacted = true
        let contact5 = Contact()
        contact5.name = "Summer Jackson"
        contact5.phoneNumber = "+421 014 090 074"
        contact5.emailAddress = "summeson@gmail.com"
        contact5.workplace = "Wilkinson LLC"
        contact5.isContacted = true
        
        // change on 'people = []' when example data isn't required
        people = [contact1, contact2, contact3, contact4, contact5]
        
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Contact].self, from: data) {
                people = decoded
                return
            }
        }
    }
    
    func add(_ contact: Contact) {
        people.append(contact)
        save()
    }
    
    func toggle(_ contact: Contact) {
        objectWillChange.send()
        contact.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            saveFile(data: encoded)
        }
    }
    
    private func saveFile(data: Data) {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch let error {
            print("Cound not write data: " + error.localizedDescription)
        }
    }
    
    private func loadFile() -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
