//
//  MembersView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import UserNotifications
import SwiftUI
import CodeScanner

enum FilterType {
    case all, contacted, uncontacted
}

enum SortType {
    case name, recent
}

struct ContactsView: View {
    
    @EnvironmentObject var contacts: Contacts
    @State private var showingScanner = false
    @State private var showingSortOptions = false
    @State var sort: SortType = .name
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .all: return "You have met"
        case .contacted: return "Contacted"
        case .uncontacted: return "Uncontacted"
        }
    }
    
    var filteredContacts: [Contact] {
        switch filter {
        case .all:
            return contacts.people
        case .contacted:
            return contacts.people.filter { $0.isContacted }
        case .uncontacted:
            return contacts.people.filter { !$0.isContacted }
        }
    }
    
    var filteredSortedContacts: [Contact] {
        switch sort {
        case .name:
            return filteredContacts.sorted { $0.name < $1.name }
        case .recent:
            return filteredContacts.sorted { $0.date > $1.date }
        }
    }
    
    let random = ["Vanessa Wood\n+421 427 001 862\nvanesood@gmail.com\nHarris, Baker and Harrison",
                  "Kimberly James\n+421 656 923 217\nkimbemes@gmail.com\nMatthews and Sons",
                  "Euan Rankin\n+421 759 528 453\neuan.rankin@random.com\nBailey-Ellis",
                  "Wayne Knight\n+44(0)5020 49628\nwayneght@gmail.com\nRussell-Bailey",
                  "Lola Khan\n+257 3484 703 302\nlolahan@gmail.com\nEvans-Allen",
                  "Chris Russell\n+421 045 837 608\nchrisell@gmail.com\nMason, Allen and White",
                  "MUDr. Vilma Plskova DSc.\n+421 045 837 608\nmudrvdsc@gmail.com\nVesela-Vasicek",
                  "Nina Simonova\n+421 561 147 300\n421 561 147 300\nHolubova and Jurik"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedContacts) { contact in

                    HStack(spacing: 10) {
                        if self.filter == .all {
                            if contact.isContacted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.pink)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .opacity(0)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(contact.workplace.uppercased())
                                .font(.custom("Helvetica-light", size: 11))
                                .padding(.bottom, 5)
                                
                            Text(contact.name)
                                .font(.custom("Helvetica-bold", size: 15))
                                .foregroundColor(.primaryDark)
                            
                            VStack(alignment: .leading, spacing: 3) {
                                HStack(spacing: 15) {
                                    Text(contact.phoneNumber)
                                    Text(contact.emailAddress)
                                    Spacer()
                                }
                            }
                            .font(.custom("Helvetica", size: 13))
                            .foregroundColor(.primaryDark)
                            .padding(.top, 10)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                        
                    .padding([.top, .bottom], 10)
                    .padding(.leading, 25)
                    .background(Color.customWhite)
                    .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.7), radius: 5, x: -2.5, y: -2.5)
                        
                    .contextMenu {
                        Button(contact.isContacted ? "Mark as Uncontacted" : "Mark as Contacted") {
                            self.contacts.toggle(contact)
                        }
                        if !contact.isContacted {
                            Button("Remind me in 1 hour") {
                                self.addNotifications(for: contact)
                            }
                        }
                    }
                }
                .listRowBackground(Color.customWhite).edgesIgnoringSafeArea(.all)
            }
            .padding(.top, 10)
            .background(Color.customWhite)
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {
                self.showingSortOptions = true
                }) {
                    Text("Sort")
                        .foregroundColor(.pink)
                        .frame(width: 80, height: 80, alignment: .leading)
                        .contentShape(Rectangle())
                }, trailing: Button(action: {
                    self.showingScanner = true
                }) {
                    Image(systemName: "qrcode")
                        .foregroundColor(.pink)
                        .frame(width: 80, height: 80, alignment: .trailing)
                        .contentShape(Rectangle())
                }
            )
            .sheet(isPresented: $showingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.random.randomElement()!, completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingSortOptions) {
                ActionSheet(title: Text("Sort by"), buttons: [
                    .default(Text((self.sort == .name ? "✓  " : "   ") + "Name"), action: {
                        self.sort = .name
                    }),
                    .default(Text((self.sort == .recent ? "✓  " : "   ") + "Recent"), action: {
                        self.sort = .recent
                    })
                ])
            }
            .modifier(ActionSheetCustom())
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 4 else { return }
            
            let person = Contact()
            person.name = details[0]
            person.phoneNumber = details[1]
            person.emailAddress = details[2]
            person.workplace = details[3]
            
            self.contacts.add(person)
            
        case .failure(let error):
            print(error.localizedDescription)
            print("Scanning failed")
        }
    }
    
    // notifications
    func addNotifications(for contact: Contact) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Don't forget to contact \(contact.name)"
            content.subtitle = "\(contact.phoneNumber), \(contact.emailAddress)"
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 1
            
            // in one hour:
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: dateComponents, repeats: false)
           
            // test - 30 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Notifications are not allowed")
                    }
                }
            }
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(filter: .contacted)
    }
}
