//
//  AppController.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 13.12.2024.
//

import Foundation
import OpenAI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


enum AuthState {
    case undefined
    case unauthorized
    case authorized
}


class AppController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSigningUp: Bool = true
    @Published var authState: AuthState = .undefined
    private var userId: String = ""
    private var openAI: OpenAI { OpenAI(apiToken: getApiKey())}

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
            print(result)
            return result.choices[0].message.content?.string ?? "No response"
        } catch {
            print(error)
            return "Problem with Network"
        }
    }
    
    func askMentor(message: String) async -> String {
        return ""
    }
    
    
    private lazy var db: Firestore = {
            Firestore.firestore()
        }()
    
    func listenToAuthChanges() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.authState = (user != nil ? .authorized : .unauthorized)
            self.userId = user?.uid ?? ""
        }
    }
    
    func registerUser() async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            print("User created successfully with UID: \(authResult.user.uid)")
        } catch {
            print("Error creating user: \(error.localizedDescription)")
            throw error // Re-throw the error for the calling function to handle
        }
    }
    
    func authorizeUser() async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("User authenticated successfully with UID: \(authResult.user.uid)")
        } catch {
            print("Error authenticating user: \(error.localizedDescription)")
            throw error // Re-throw the error for the calling function to handle
        }
    }

    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
    func saveData(data: String) {
//        do {
//            try db.collection("users").document(userId).setData(from: userSettings)
//        } catch let error {
//            print("Error writing user settings to Firestore: \(error)")
//        }
    }
    
    func loadData() {
//        var userSettings = UserSettings.empty
//
//        if userId.isEmpty {
//            print("User ID is not set.")
//        }
//
//        // Load from Firestore
//        db.collection("users").document(userId).getDocument { document, error in
//            if let error = error {
//                print("Error loading user settings from Firestore: \(error)")
//                return
//            }
//
//            if let document = document, document.exists {
//                do {
//                    userSettings = try document.data(as: UserSettings.self)
//                } catch let error {
//                    print("Error decoding user settings from Firestore: \(error)")
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//
//        return userSettings
    }
    
}
