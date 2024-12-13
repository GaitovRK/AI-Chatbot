//
//  ContentView.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 30.10.2024.
//

import SwiftUI

struct Mentor: Identifiable {
    var id: Int
    var name: String
    var image: String
}

struct ContentView: View {
    @StateObject var appController = AppController()
    
    var mentors: [Mentor] = [
        Mentor(id: 0, name: "Steve Jobs", image: "person.fill"),
        Mentor(id: 1, name: "Bill Gates", image: "person.fill"),
        Mentor(id: 2, name: "Elon Musk", image: "person.fill"),
        Mentor(id: 3, name: "Mark Zuckerberg", image: "person.fill"),
        Mentor(id: 4, name: "Jeff Bezos", image: "person.fill"),
        Mentor(id: 5, name: "Rashid Gaitov", image: "person.fill"),
//        Mentor(id: 6, name: "Sergey Brin", image: "sergey"),
//        Mentor(id: 7, name: "Larry Page", image: "larry"),
//        Mentor(id: 8, name: "Tim Cook", image: "tim"),
//        Mentor(id: 9, name: "Satya Nadella", image: "satya"),
//        Mentor(id: 10, name: "Sundar Pichai", image: "sundar"),
//        Mentor(id: 11, name: "Jack Ma", image: "jack"),
//        Mentor(id: 12, name: "Larry Ellison", image: "larryellison"),
//        Mentor(id: 13, name: "Reed Hastings", image: "reed")
    ]
    
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
                            ForEach(mentors) { mentor in
                                NavigationLink {
                                    ChatView()
                                } label: {
                                    showMentor(name: mentor.name, image: mentor.image)
                                }

                            }
                        }
                        .padding()
                }
                
                HStack {
                    TextField("Enter message...", text: $message)
                        .padding()
                        .cornerRadius(10)
                        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                    
                    
                    Button(action: {
                        Task {
                            let response = await appController.askGPT4_o_mini(message: message)
                            print(response)
                        }
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.padding(24)
            }
        }
    }
    
    private func showMentor(name: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
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
