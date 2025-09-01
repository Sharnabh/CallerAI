//
//  ContentView.swift
//  CallerAI
//
//  Created by Sharnabh on 31/08/25.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var viewModel = ContactsViewModel()
    @State private var isCallActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (viewModel.contacts) { contact in
                        HStack {
                            Text(contact.name)
                            Spacer()
                            
                            if viewModel.selectedContact.contains(contact) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.blue)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.toggleSelection(for: contact)
                        }
                    }
                }
                
                Button(action: {
                    if !viewModel.selectedContact.isEmpty {
                        isCallActive = true
                    }
                }) {
                    Text("Start AI Call (\(viewModel.selectedContact.count))")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.selectedContact.isEmpty ? Color.gray : Color.blue)
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(viewModel.selectedContact.isEmpty)
                
                .fullScreenCover(isPresented: $isCallActive) {
                    CallView(viewModel: CallViewModel(selectedContact: viewModel.selectedContact))
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactsView()
}
