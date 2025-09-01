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
            Contact(name: "John Appleseed", phoneNumber: "5550101"),
            Contact(name: "Kate Bell", phoneNumber: "5550102"),
            Contact(name: "Anna Haro", phoneNumber: "5550103"),
            Contact(name: "Daniel Higgins Jr.", phoneNumber: "5550104"),
            Contact(name: "David Taylor", phoneNumber: "5550105")
        ]
    }
    
    func toggleSelection(for contact: Contact) {
        if selectedContact.contains(contact) {
            selectedContact.remove(contact)
        } else {
            selectedContact.insert(contact)
        }
    }
    
    func clearSelection() {
        selectedContact.removeAll()
    }
    
    func selectSingleContact(_ contact: Contact) {
        selectedContact = [contact]
    }
}
