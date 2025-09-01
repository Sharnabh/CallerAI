//
//  Contact.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import Foundation

struct Contact: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let phoneNumber: String
}
