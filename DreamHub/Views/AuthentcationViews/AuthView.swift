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
    @State var signal = 0
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            Image("moon.zzz.fill")
                .frame(width: 30, height: 30)
                .padding(.bottom, 50)
            
            
            HStack{
                ZStack{
                    TextField("Email", text: $email)
                        .lineLimit(1)
                        .scrollContentBackground(.hidden)
                        .padding(.leading,15)
                        .frame(height:50)
                        .background(Color.indigo.opacity(0.2))
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
                    TextField("••••••••", text: $password)
                        .lineLimit(1)
                        .scrollContentBackground(.hidden)
                        .padding(.leading,15)
                        .frame(height:50)
                        .background(Color.indigo.opacity(0.2))
                        .disableAutocorrection(true)
                    
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
            
            Button(action: {
                if signal == 0{
                    authMgr.signInUser(email: email, password: password)
                } else {
                    authMgr.registerUser(email: email, password: password)
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
            
            Button(action: {
                if signal == 0{
                    signal == 1
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
