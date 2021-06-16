//
//  MembersView.swift
//  Evenet
//
//  Created by Valerie 👩🏼‍💻 on 05/04/2020.
//

import SwiftUI
import UserNotifications
import CodeScanner

enum FilterType { case all, contacted, uncontacted }
enum SortType { case name, recent }

struct ContactsView: View {
    @EnvironmentObject var contacts: MyContacts
    let filter: FilterType

    @State private var showingScanner = false
    @State private var showingSortOptions = false
    @State private var sortBy: SortType = .name
    
    private var title: String {
        switch filter {
        case .all: return "You have met"
        case .contacted: return "Contacted"
        case .uncontacted: return "Uncontacted"
        }
    }
    
    private var filteredContacts: [Contact] {
        switch filter {
        case .all:
            return contacts.people
        case .contacted:
            return contacts.people.filter { $0.isContacted }
        case .uncontacted:
            return contacts.people.filter { !$0.isContacted }
        }
    }
    
    private var filteredSortedContacts: [Contact] {
        switch sortBy {
        case .name:
            return filteredContacts.sorted { $0.name < $1.name }
        case .recent:
            return filteredContacts.sorted { $0.date > $1.date }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(filteredSortedContacts) { contact in
                        ContactView(contact: contact, filter: filter)
                            .contextMenu {
                                Button(contact.isContacted ? "Mark as Uncontacted" : "Mark as Contacted") {
                                    contacts.toggle(contact)
                                }
                                if !contact.isContacted {
                                    Button("Remind me in 1 hour") {
                                        addNotifications(for: contact)
                                    }
                                }
                            }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }            
            .padding(.top, 10)
            .background(Color.pearl)
            .navigationBarTitle(title)
            .navigationBarItems(
                leading:
                    BarButtonView(text: "Sort") {
                        showingSortOptions = true
                    },
                trailing:
                    BarButtonView(systemImage: "qrcode") {
                        showingScanner = true
                    }
            )
            .sheet(isPresented: $showingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: randomContact.randomElement()!, completion: handleScan)
            }
            .actionSheet(isPresented: $showingSortOptions) {
                ActionSheet(title: Text("Sort by"), buttons: [
                    .default(Text((sortBy == .name ? "✓  " : "   ") + "Name"), action: {
                        sortBy = .name
                    }),
                    .default(Text((sortBy == .recent ? "✓  " : "   ") + "Recent"), action: {
                        sortBy = .recent
                    })
                ])
            }
            .modifier(ActionSheetCustom())
        }
    }
    
    // MARK: - Simulated data
    private let randomContact = [
        "Vanessa Wood\n+421 427 001 862\nvanesood@gmail.com\nHarris, Baker and Harrison",
        "Kimberly James\n+421 656 923 217\nkimbemes@gmail.com\nMatthews and Sons",
        "Euan Rankin\n+421 759 528 453\neuan.rankin@random.com\nBailey-Ellis",
        "Wayne Knight\n+44(0)5020 49628\nwayneght@gmail.com\nRussell-Bailey",
        "Lola Khan\n+257 3484 703 302\nlolahan@gmail.com\nEvans-Allen",
        "Chris Russell\n+421 045 837 608\nchrisell@gmail.com\nMason, Allen and White",
        "MUDr. Vilma Plskova DSc.\n+421 045 837 608\nmudrvdsc@gmail.com\nVesela-Vasicek",
        "Nina Simonova\n+421 561 147 300\n421 561 147 300\nHolubova and Jurik"
    ]
    
    // MARK: - QR scan
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        showingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 4 else { return }
            
            let newContact = Contact(name: details[0], phoneNumber: details[1], emailAddress: details[2], workplace: details[3])
            
            contacts.add(newContact)
            
        case .failure(let error):
            print("Scanning failed." + error.localizedDescription)
        }
    }
    
    // MARK: - Notifications
    private func addNotifications(for contact: Contact) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Don't forget to contact \(contact.name)"
            content.subtitle = "\(contact.phoneNumber), \(contact.emailAddress)"
            content.sound = UNNotificationSound.default
            
            // MARK: - Notification time
            // var dateComponents = DateComponents()
            // dateComponents.hour = 1
            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            /// Testing: Notification in 5 sec instead 1 hour
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
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
                        print("Notifications are not allowed.")
                    }
                }
            }
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(filter: .contacted)
            .environmentObject(MyContacts())
    }
}
