//
//  CallView.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import SwiftUI

struct CallView: View {
    
    @ObservedObject var viewModel: CallViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("AI Call in Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List(viewModel.participants) { participant in
                HStack {
                    VStack(alignment: .leading) {
                        Text(participant.name)
                            .font(.headline)
                    }
                    Spacer()
                    
                    Text(participant.status.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(statusColor(for: participant.status))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(statusColor(for: participant.status).opacity(0.2))
                        .cornerRadius(8)
                }
            }
            
            Button(action: {
                dismiss()
            }) {
                Text("End Call")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            viewModel.startCall()
        }
    }
    
    private func statusColor(for status: CallParticipants.CallStatus) -> Color {
        switch status {
            
        case .ringing:
                .orange
        case .connected:
                .green
        case .ended:
                .gray
        }
    }
}

#Preview {
    let dummyContacts: Set<Contact> = [
                Contact(name: "John Appleseed", phoneNumber: "555-0101"),
                Contact(name: "Kate Bell", phoneNumber: "555-0102")
            ]
    CallView(viewModel: CallViewModel(selectedContact: dummyContacts))
}
