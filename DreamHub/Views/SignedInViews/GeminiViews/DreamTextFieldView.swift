//
//  DreamTextFieldView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/14/25.
//

import Foundation
import SwiftUI

struct DreamTextFieldView: View {
    @Binding var value1: String
    @Binding var value2: String
    @State var focused1: Bool = false
    @State var focused2: Bool = false
    
    var body: some View {
        if focused1{
            VStack{
                TextEditor(text: $value1)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 300)
                    .background(Color.indigo.opacity(0.2))
                    .disableAutocorrection(true)
                
                Spacer()
                HStack(alignment: .center){
                    Button(action: {
                        focused1 = false
                    }, label: {
                        Text("Confirm")
                            .fontWeight(.bold)
                    })
                    .foregroundColor(.brown)
                    .cornerRadius(10)
                    .padding(.trailing,60)
                    
                    Text("|")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                        .frame(alignment: .center)
                    
                    Button(action: {
                        value1 = ""
                    }, label: {
                        Text("Clear")
                            .fontWeight(.bold)
                    })
                    .padding(.leading,60)
                    .foregroundColor(.red)
                    .cornerRadius(10)
                }
                Spacer()
            }
            .border(.gray, width: 2)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
        } else {
            HStack{
                ZStack{
                    TextField("What did you dream about?", text: $value1)
                        .lineLimit(1)
                        .scrollContentBackground(.hidden)
                        .padding(.leading,15)
                        .frame(height:50)
                        .background(Color.indigo.opacity(0.2))
                        .disableAutocorrection(true)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle()) // makes the clear layer tappable
                        .onTapGesture {
                            focused1 = true
                            focused2 = false
                        }
                }
                
                Button(action: {
                    value1 = ""
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
        
        if focused2{
            VStack{
                TextEditor(text: $value2)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 300)
                    .background(Color.indigo.opacity(0.2))
                    .disableAutocorrection(true)
                
                Spacer()
                HStack(alignment: .center){
                    Button(action: {
                        focused2 = false
                    }, label: {
                        Text("Confirm")
                            .fontWeight(.bold)
                    })
                    .foregroundColor(.brown)
                    .cornerRadius(10)
                    .padding(.trailing,60)
                    
                    Text("|")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                        .frame(alignment: .center)
                    
                    Button(action: {
                        value2 = ""
                    }, label: {
                        Text("Clear")
                            .fontWeight(.bold)
                    })
                    .padding(.leading,60)
                    .foregroundColor(.red)
                }
                Spacer()
                
            }
            .border(.gray, width: 2)
            .background(Color.indigo.opacity(0.2))
            .cornerRadius(10)
            
        } else {
            HStack{
                ZStack{
                    TextField("what's happening in lfe recently?", text: $value2)
                        .lineLimit(1)
                        .padding(.leading,15)
                        .scrollContentBackground(.hidden)
                        .padding(5)
                        .frame(height:50)
                        .background(Color.indigo.opacity(0.2))
                        .disableAutocorrection(true)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle()) // makes the clear layer tappable
                        .onTapGesture {
                            focused2 = true
                            focused1 = false
                        }
                }
                
                Button(action: {
                    value2 = ""
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
    }
}
