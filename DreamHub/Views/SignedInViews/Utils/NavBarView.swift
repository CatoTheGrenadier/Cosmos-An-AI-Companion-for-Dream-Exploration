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
            
            Button {
                page = 3
            } label: {
                Image(systemName: "person.fill")
            }
            .frame(alignment: .trailing)
        }
        .padding()
        
    }
}
