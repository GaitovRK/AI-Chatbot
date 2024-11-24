//
//  ContentView.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 30.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    var mentors = ["Steve Jobs", "Bill Gates", "Elon Musk", "Mark Zuckerberg", "Jeff Bezos", "Rashid Gaitov", "Sergey Brin", "Larry Page", "Tim Cook", "Satya Nadella", "Sundar Pichai", "Jack Ma", "Larry Ellison", "Reed Hastings", "Brian Chesky", "Travis Kalanick", "Dara Khosrowshahi", "Daniel Ek", "Daniel Zhang", "Daniel Dines", "Daniel Schulman"]
    let rows = [
            GridItem(.flexible())
        ]
    @State var message: String = ""
    
    var body: some View {
            
        NavigationView {
            VStack {
                Text("AI Mentor")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 42) {
                            ForEach(mentors, id: \.self) { mentor in
                                    showMentor(name: mentor)
                            }
                        }
                        .padding()
                }
                
                TextField("Write a message", text: $message)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }
    
    private func showMentor(name: String) -> some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 10)

            Text("\(name)'s Mentor")
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: 100)
        }
    }
}

#Preview {
    ContentView()
}
