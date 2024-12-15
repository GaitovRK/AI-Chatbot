//
//  AuthorizationView.swift
//  AI Mentor
//
//  Created by Rashid Gaitov on 15.12.2024.
//

import SwiftUI

struct AuthorizationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isSigningUp: Bool = true
    @State var errorMessage: String?
    @State var isAlertPresented: Bool = false
    @EnvironmentObject var appController: AppController

    var body: some View {
        Group {
            switch appController.authState {
            case .undefined:
                Text("Loading...")
            case .unauthorized:
                form
            case .authorized:
                ContentView()
            }
        }
        .onAppear {
            appController.listenToAuthChanges()
        }
        .alert(isPresented: $isAlertPresented, content: {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "An unknown error occured."), dismissButton: .default(Text("OK")))
        })
}
    
    private var form: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(isSigningUp ? "Register" : "Sign In")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $appController.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                            
                SecureField("Password", text: $appController.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    

                Button {
                    Task {
                        do {
                            if isSigningUp {
                                try await appController.registerUser()
                            } else {
                                try await appController.authorizeUser()
                            }
                        } catch {
                            errorMessage = error.localizedDescription
                            isAlertPresented = true
                        }
                    }
                    
                } label: {
                    Text(isSigningUp ? "Sign Up" : "Sign In")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Secondary"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                            
                Button {
                    isSigningUp.toggle()
                } label: {
                    Text(isSigningUp ? "I already have an account" : "Create an account")
                }
            }.padding()
        }
    }
}

#Preview {
    AuthorizationView()
        .environmentObject(AppController())
}
