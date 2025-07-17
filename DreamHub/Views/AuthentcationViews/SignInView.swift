//
//  SignInView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @ObservedObject var authMgr: AuthMgr
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("moon.zzz.fill")
                .frame(width: 30, height: 30)
                .padding(.bottom, 30)
            
            
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
            

            
        }
        .padding()
    }
}
