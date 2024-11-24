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
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                    }
                }
                .frame(maxHeight: .infinity)  // Allow the List to take up all available space
                
                // TextField for input
                HStack {
                    TextField("Enter message...", text: $currentMessage)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)  // Make the TextField take up full width
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
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
