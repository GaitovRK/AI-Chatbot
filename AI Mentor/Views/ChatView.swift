//
//  ChatView.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 24.11.2024.
//

import SwiftUI

enum Author {
    case bot
    case user
}

struct Message: Hashable {
    var text: String
    var author: Author
}

struct ChatView: View {
    @State private var messages: [Message] = []  // Array to store the messages
    @State private var currentMessage: String = ""  // To store the current message being typed
    @StateObject var appController: AppController = AppController()

    var body: some View {
            VStack {
                // Chat messages list
                ScrollView {
                    VStack {
                        ForEach(messages, id: \.self) { message in
                            if message.author == .bot {
                                botMessageView(message: message.text)
                            } else {
                                userMessageView(message: message.text)
                            }
                        }
                    }
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 100)
                        .foregroundColor(Color("BG"))
                        .shadow(radius: 1)
                    HStack {
                        TextField("Enter message...", text: $currentMessage)
                            .padding()
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                        
                        
                        Button(action: {
                            sendMessage(currentMessage)
                        }) {
                            Image(systemName: "paperplane.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.bottom, 20)
                    .padding(.horizontal)

                }
            }.ignoresSafeArea(edges: .bottom)
        }

        // Function to handle sending messages
        private func sendMessage(_ message: String) {
            guard !message.isEmpty else { return }  // Don't send empty messages
            messages.append(Message(text: message, author: .user))  // Add the message to the array
            Task {
                let response = await appController.askGPT4_o_mini(message: message)  // Get the response from the AI
                messages.append(Message(text: response, author: .bot))  // Add the response to the array
                currentMessage = ""  // Clear the input field after sending
            }
        }
    
    private func userMessageView(message: String) -> some View {
        
        ZStack {
            Text(message)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.blue)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
        }.shadow(radius: 3)

    }
    
    private func botMessageView(message: String) -> some View {
        ZStack {
            Text(message)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.messageBackground)
                }
                .foregroundColor(.chatText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }.shadow(radius: 3)
    }
    
}

#Preview {
    ChatView()
}
