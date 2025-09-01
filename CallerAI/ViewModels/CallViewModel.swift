//
//  CallViewModel.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import Foundation
import AVFoundation
import Combine

class CallViewModel: ObservableObject {
    @Published var participants: [CallParticipants] = []
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var cancellables = Set<AnyCancellable>()
    private var hasSpokenGreeting = false
    
    init(selectedContact: Set<Contact>) {
        self.participants = selectedContact.map {
            CallParticipants(id: $0.id, name: $0.name, status: .ringing)
        }
    }
    
    func startCall() {
        simulateCallProgress()
    }
    
    private func speak(_ text: String) {
        let utterence = AVSpeechUtterance(string: text)
        utterence.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterence.rate = 0.5
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .voiceChat, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup Audio Session")
        }
        
        speechSynthesizer.speak(utterence)
    }
    
    private func simulateCallProgress() {
        for participant in participants {
            let ringingDelay = Double.random(in: 1...3)
            DispatchQueue.main.asyncAfter(deadline: .now() + ringingDelay) {
                guard self.participants.contains(where: { $0.id == participant.id && $0.status == .ringing }) else { return }
                
                let shouldConnect = Bool.random()
                if shouldConnect {
                    self.updateStatus(for: participant.id, to: .connected)
                    
                    let callDuration = Double.random(in: 5...15)
                    DispatchQueue.main.asyncAfter(deadline: .now() + callDuration) {
                        self.updateStatus(for: participant.id, to: .ended)
                    }
                } else {
                    self.updateStatus(for: participant.id, to: .ended)
                }
            }
        }
    }
    
    private func updateStatus(for participantId: UUID, to newStatus: CallParticipants.CallStatus) {
        if let index = participants.firstIndex(where: {$0.id == participantId}) {
            participants[index].status = newStatus
        }
        
        if newStatus == .connected && !hasSpokenGreeting {
            speak("Hello This is AI Calling Assistant")
            hasSpokenGreeting = true
        }
    }
    
}
