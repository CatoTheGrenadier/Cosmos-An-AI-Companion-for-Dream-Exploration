//
//  SignInView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @ObservedObject var authMgr: AuthMgr
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State var signal = 0
    @State var isLoading = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            
            Image(systemName: "moon.zzz.fill")
                .frame(width: 200, height: 200)
                .padding(.bottom, 80)
            
            
            HStack{
                ZStack{
                    TextField("Email", text: $email)
                        .lineLimit(1)
                        .scrollContentBackground(.hidden)
                        .padding(.leading,15)
                        .frame(height:50)
                        .background(Color(.systemGray6))
                        .disableAutocorrection(true)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                }
                
                Button(action: {
                    email = ""
                }, label: {
                    Image(systemName: "delete.backward.fill")
                })
                .padding(.trailing)
                .foregroundColor(.gray)
            }
            .frame(height:50)
            .border(.gray, width: 2)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
            
            
            HStack{
                ZStack{
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                }
                
                Button(action: {
                    password = ""
                }, label: {
                    Image(systemName: "delete.backward.fill")
                })
                .padding(.trailing)
                .foregroundColor(.gray)
            }
            .frame(height:50)
            .border(.gray, width: 2)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
            
            if signal == 1 {
                HStack{
                    ZStack{
                        SecureField("Confirm Password", text: $confirmPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                    
                    Button(action: {
                        confirmPassword = ""
                    }, label: {
                        Image(systemName: "delete.backward.fill")
                    })
                    .padding(.trailing)
                    .foregroundColor(.gray)
                }
                .frame(height:50)
                .border(.gray, width: 2)
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
                            .background(Color.blue)
                            .cornerRadius(10)
                    } else {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
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
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Text("Sign Up")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                } else {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Text("Sign in")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .padding()
    }
}
