//
//  SignInView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct AuthView: View {
    @ObservedObject var authMgr: AuthMgr
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State var signal = 0
    @State var isLoading = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            
            Spacer()
            
            Image(systemName: "moon.zzz.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.indigo, .yellow)
            
            Spacer()
            
            
            HStack{
                TextField("Email", text: $email)
                    .lineLimit(1)
                    .scrollContentBackground(.hidden)
                    .padding(.leading,15)
                    .frame(height:50)
                    .background(Color(.systemGray6))
                    .disableAutocorrection(true)
                
                Button(action: {
                    email = ""
                }, label: {
                    Image(systemName: "delete.backward.fill")
                })
                .padding(.trailing)
                .foregroundColor(.gray)
            }
            .frame(height:50)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
            
            
            HStack{
                SecureField("Password", text: $password)
                    .lineLimit(1)
                    .scrollContentBackground(.hidden)
                    .padding(.leading,15)
                    .frame(height:50)
                    .background(Color(.systemGray6))
                    .disableAutocorrection(true)
                
                Button(action: {
                    password = ""
                }, label: {
                    Image(systemName: "delete.backward.fill")
                })
                .padding(.trailing)
                .foregroundColor(.gray)
            }
            .frame(height:50)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
            
            if signal == 1 {
                HStack{
                    SecureField("Confirm Password", text: $confirmPassword)
                        .lineLimit(1)
                        .scrollContentBackground(.hidden)
                        .padding(.leading,15)
                        .frame(height:50)
                        .background(Color(.systemGray6))
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        confirmPassword = ""
                    }, label: {
                        Image(systemName: "delete.backward.fill")
                    })
                    .padding(.trailing)
                    .foregroundColor(.gray)
                }
                .frame(height:50)
                .background(Color.indigo.opacity(0.2))
                .cornerRadius(10)
            }
            
            
            if isLoading{
                Button(action: {
                    
                }) {
                    Text("Processing...")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.vertical)
                
            } else if (signal == 1 && password != confirmPassword) {
                Button(action: {
                    
                }) {
                    Text("Password doesn't match!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.vertical)
                
            } else {
                Button(action: {
                    Task{
                        isLoading = true
                        if signal == 0{
                            await authMgr.signInUser(email: email, password: password)
                        } else {
                            await authMgr.registerUser(email: email, password: password)
                        }
                        isLoading = false
                    }
                }) {
                    if signal == 0{
                        Text("Log in")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.brown.opacity(1))
                            .cornerRadius(10)
                    } else {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.brown.opacity(1))
                            .cornerRadius(10)
                        }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            
            Button(action: {
                if signal == 0{
                    signal = 1
                } else {
                    signal = 0
                }
            }) {
                if signal == 0{
                    HStack(alignment: .bottom) {
                        Text("Don't have an account?")
                            .foregroundColor(.black.opacity(0.7))
                            .font(.caption)
                        Text("Sign Up")
                            .foregroundColor(.craftBrown)
                            .fontWeight(.bold)
                    }
                } else {
                    HStack(alignment: .bottom)  {
                        Text("Already have an account?")
                            .foregroundColor(.black.opacity(0.7))
                            .font(.caption)
                        Text("Sign in")
                            .foregroundColor(.craftBrown)
                            .fontWeight(.bold)
                    }
                }
            }
            
            Button(action: {
                Task {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        await authMgr.signInUser(presenting: rootViewController)
                    } else {
                        authMgr.authError = "Could not find a view controller to present Google Sign-In"
                    }
                }
            }) {
                Image("Google_icon")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding(.top, 25)
            
            
        }
        .padding()
    }
}
