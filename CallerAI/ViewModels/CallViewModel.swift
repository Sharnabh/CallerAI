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
    
    init(selectedContact: Set<Contact>) {
        self.participants = selectedContact.map {
            CallParticipants(id: $0.id, name: $0.name, status: .ringing)
        }
    }
    
    func startCall() {
        speak("Hello This is AI Calling Assistant")
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
        for (index, participant) in participants.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index * 2 + 2)) {
                self.updateStatus(for: participant.id, to: .connected)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index * 2 + 8)) {
                self.updateStatus(for: participant.id, to: .ended)
            }
        }
    }
    
    private func updateStatus(for participantId: UUID, to newStatus: CallParticipants.CallStatus) {
        if let index = participants.firstIndex(where: {$0.id == participantId}) {
            participants[index].status = newStatus
        }
    }
    
}
