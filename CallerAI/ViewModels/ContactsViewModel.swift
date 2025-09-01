//
//  ContactsViewModel.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var selectedContact: Set<Contact> = []
    
    init() {
        loadContacts()
    }
    
    private func loadContacts() {
        self.contacts = [
            Contact(name: "John Appleseed", phoneNumber: "555-0101"),
            Contact(name: "Kate Bell", phoneNumber: "555-0102"),
            Contact(name: "Anna Haro", phoneNumber: "555-0103"),
            Contact(name: "Daniel Higgins Jr.", phoneNumber: "555-0104"),
            Contact(name: "David Taylor", phoneNumber: "555-0105")
        ]
    }
    
    func toggleSelection(for contact: Contact) {
        if selectedContact.contains(contact) {
            selectedContact.remove(contact)
        } else {
            selectedContact.insert(contact)
        }
    }
}
