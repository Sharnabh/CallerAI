//
//  File.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import Foundation

struct CallParticipants: Identifiable, Hashable {
    let id: UUID
    let name: String
    var status: CallStatus
    
    enum CallStatus: String {
        case ringing = "Ringing"
        case connected = "Connected"
        case ended = "Ended"
    }
}
