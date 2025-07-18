//
//  FirebaseAuth.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class AuthMgr: ObservableObject {
    @Published var currentUserUID: String? = nil
    @Published var authError: String? = nil
    @Published var isAuthenticated: Bool = false
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init(){
        authStateHandle = Auth.auth().addStateDidChangeListener{[weak self] auth, user in
            DispatchQueue.main.async {
                if let user = user {  // user is signed in
                    self?.currentUserUID = user.uid
                    self?.authError = nil
                    self?.isAuthenticated = true
                    print("User is signed in: UID = \(user.uid), Email = \(user.email ?? "N/A")")
                } else {  // user not signed in
                    self?.currentUserUID = nil
                    self?.authError = nil
                    self?.isAuthenticated = false
                    print("No user is signed in.")
                }
            }
        }
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
    
    func registerUser(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Successfully registered user: \(authResult.user.email ?? "N/A")")
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                print("Registration failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    func signInUser(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("Successfully signed in user: \(authResult.user.email ?? "N/A")")
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                print("Sign-in failed: \(error.localizedDescription)")
            }
        }
    }
    
    func signInUser(presenting viewController: UIViewController) async {
        self.authError = nil
        do {
            let authResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
            guard let idToken = authResult.user.idToken?.tokenString else {
                throw NSError(domain: "AuthMgr", code: 0, userInfo: [NSLocalizedDescriptionKey: "Google ID token not found"])
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authResult.user.accessToken.tokenString)
            _ = try await Auth.auth().signIn(with: credential)
            print("Successfully signed in with Google")
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                print("Sign-in failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    func signOutUser() async {
        do {
            GIDSignIn.sharedInstance.signOut()
            print("AuthMgr: Signed out from Google SDK.")
            
            try Auth.auth().signOut()
            print("Successfully signed out")
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                print("Sign-out failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    func sendPasswordReset(to email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            DispatchQueue.main.async {
                self.authError = "Password reset email sent to \(email)."
                print(self.authError)
            }
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                print("Sign-out failed: \(error.localizedDescription)")
            }
        }
    }
}

