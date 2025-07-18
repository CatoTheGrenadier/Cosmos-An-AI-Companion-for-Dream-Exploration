//
//  NavBarView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/28/25.
//

import Foundation
import SwiftUI

struct NavBarView: View {
    @Binding var page: Int
    @ObservedObject var authMgr: AuthMgr
    
    var body: some View {
        HStack{
            HStack{
                Button {
                    page = 0
                } label: {
                    Image(systemName: "bag.fill")
                }
                
                Button {
                    page = 1
                } label: {
                    Image(systemName: "heart.fill")
                }
                
                Button {
                    page = 2
                } label: {
                    Image(systemName: "car.fill")
                }
            }
            .frame(alignment: .leading)
            
            Spacer()
            
            Menu {
                Button(action: {
                    Task {
                        await authMgr.signOutUser()
                    }
                }, label: {
                    HStack(spacing: 5){
                        Image(systemName: "arrow.uturn.left")
                            .foregroundColor(.black)
                        Text("Log out")
                            .foregroundColor(.black)
                    }
                })
                
                Button(action: {
                    page = 3
                }, label: {
                    HStack{
                        Text("Profile")
                            .foregroundColor(.black)
                    }
                })
            } label: {
                Image(systemName: "person.fill")
            }
            .frame(alignment: .trailing)
        }
        .padding()
        
    }
}
