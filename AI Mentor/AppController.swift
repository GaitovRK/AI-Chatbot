//
//  AppController.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 13.12.2024.
//

import Foundation
import OpenAI

class AppController: ObservableObject {
    var openAI: OpenAI { OpenAI(apiToken: getApiKey())}

    func getApiKey() -> String {
        if let path = Bundle.main.path(forResource: "Environment", ofType: "plist"),
           let secrets = NSDictionary(contentsOfFile: path),
           let apiKey = secrets["API_KEY"] as? String {
            return apiKey
        }
        return ""
    }
    
    func askGPT4_o_mini(message: String) async -> String{
        
        let query = ChatQuery(messages: [.user(.init(content: .string(message)))], model: .gpt4_o_mini)

        do {
            let result = try await openAI.chats(query: query)
            return result.choices[0].message.content?.string ?? "No response"
        } catch {
            print(error)
            return "Problem with Network"
        }
    }
    
}
