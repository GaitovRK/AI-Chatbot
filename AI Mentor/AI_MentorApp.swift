//
//  AI_MentorApp.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 30.10.2024.
//

import SwiftUI
import FirebaseCore

@main
struct AI_MentorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AuthorizationView()
                .environmentObject(AppController())
        }
    }
}
