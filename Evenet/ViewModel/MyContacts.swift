//
//  MyContacts.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 25/05/2021.
//

import Foundation

class MyContacts: ObservableObject {
    @Published private(set) var people: [Contact]
    static let saveKey = "ContactsEvenet"
    
    init() {
        /// example data for preview
        people = Bundle.main.decode("defaultContacts.json")

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
        if let index = people.firstIndex(where: { $0.id == contact.id }) {
            people[index].toggleContacted()
            save()
        }
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
