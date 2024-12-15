//
//  AppDelegate.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 15.12.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("The application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    return true
  }
}
