//
//  ChatView.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 24.11.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var messages: [String] = []  // Array to store the messages
    @State private var currentMessage: String = ""  // To store the current message being typed

    var body: some View {
            VStack {
                // Chat messages list
                List {
                    ForEach(messages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .frame(alignment: .leading)
                            .cornerRadius(10)
                    }
                }
                .frame(maxHeight: .infinity)  // Allow the List to take up all available space
                
                HStack {
                    TextField("Enter message...", text: $currentMessage)
                        .padding()
                        .cornerRadius(10)
                        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                    
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.padding()
            }
            .padding()
        }

        // Function to handle sending messages
        private func sendMessage() {
            guard !currentMessage.isEmpty else { return }  // Don't send empty messages
            messages.append(currentMessage)  // Add the message to the array
            currentMessage = ""  // Clear the input field after sending
        }
}

#Preview {
    ChatView()
}
