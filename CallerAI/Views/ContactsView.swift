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
    @State private var multiSelectMode = false
    @State private var searchText = ""
    
    var searchResults: [Contact] {
        if searchText.isEmpty {
            return viewModel.contacts
        } else {
            return viewModel.contacts.filter { contact in
                contact.name.localizedCaseInsensitiveContains(searchText) ||
                contact.phoneNumber.localizedCaseInsensitiveContains(searchText.filter("0123456789".contains))
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (searchResults) { contact in
                        HStack {
                            VStack(alignment: .leading){
                                Text(contact.name)
                                Text(contact.phoneNumber)
                                    .font(.subheadline)
                                    .padding(.vertical, 2)
                            }
                            Spacer()
                            
                            if multiSelectMode{
                                if viewModel.selectedContact.contains(contact) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.blue)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if multiSelectMode {
                                viewModel.toggleSelection(for: contact)
                            } else {
                                viewModel.selectSingleContact(contact)
                                isCallActive = true
                            }
                        }
                        .onLongPressGesture {
                            if !multiSelectMode {
                                multiSelectMode = true
                                viewModel.clearSelection()
                                viewModel.toggleSelection(for: contact)
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                
                if multiSelectMode{
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
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                if multiSelectMode {
                    Button("Cancel") {
                        multiSelectMode = false
                        viewModel.clearSelection()
                    }
                }
            }
            .fullScreenCover(isPresented: $isCallActive, onDismiss: {
                multiSelectMode = false
                viewModel.clearSelection()
            }) {
                CallView(viewModel: CallViewModel(selectedContact: viewModel.selectedContact))
            }
        }
    }
}

#Preview {
    ContactsView()
}
