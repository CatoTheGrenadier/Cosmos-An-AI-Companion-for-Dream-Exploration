//
//  PlaceHolderView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/28/25.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI
import MarkdownUI

struct GeminiView: View {
    @ObservedObject var coreAppModel: CoreAppModel
    @State var date: Date
    @ObservedObject var gemini = GeminiLLM()
    @State var curDream: DreamModel = DreamModel()
    @State var userInputDream = ""
    @State var userInputIrlEvents = ""
    @State var unClicked = true
    
    var body: some View {
        VStack{
            if unClicked{
                VStack{
                    Text("What did you dream")
                        .font(.title)
                        .foregroundStyle(.indigo)
                        .fontWeight(.bold)
                    Text("of today?")
                        .font(.title)
                        .foregroundStyle(.indigo)
                        .fontWeight(.bold)
                }
                .padding(.top, 250)
                .padding(.horizontal, 50)
            }
            
            ZStack{
                    ScrollView{
                        VStack{
                            Markdown(curDream.savedAnalysis ?? "")
                        }
                        .padding(.horizontal,25)
                    }
                    if gemini.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                                .scaleEffect(4)
                        }
                }
            
            VStack{
                HStack{
                    TextField("Tell me about your dream!", text: $userInputDream, axis: .vertical)
                        .lineLimit(10)
                        .disableAutocorrection(true)
                        .padding()
                    Spacer()
                    Button(action: {
                        userInputDream = ""
                    }, label: {
                        Image(systemName: "delete.backward.fill")
                    })
                    .padding(.trailing)
                    .foregroundColor(.gray)
                }
                .background(Color.indigo.opacity(0.2))
                .cornerRadius(10)
                
                HStack{
                    TextField("Anything worth mention in your current life that you feel might be related to this dream?", text: $userInputIrlEvents, axis: .vertical)
                        .lineLimit(10)
                        .padding()
                        .disableAutocorrection(true)
                    Spacer()
                    Button(action: {
                        userInputIrlEvents = ""
                    }, label: {
                        Image(systemName: "delete.backward.fill")
                    })
                    .padding(.trailing)
                    .foregroundColor(.gray)
                }
                .background(Color.indigo.opacity(0.2))
                .cornerRadius(10)
            }
            .padding()
            
            HStack{
                Button(action: {
                    unClicked = false
                    gemini.dreamContent = userInputDream
                    gemini.irlEvents = userInputIrlEvents
                    gemini.generateResponse()
                    userInputDream = ""
                    userInputIrlEvents = ""
                }) {
                    Text("Interpret My Dream")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.trailing, 25)
                
                
                if (gemini.isLoading || unClicked){
                    Button(action: {
                        
                    }) {
                        Text("Processing...")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        coreAppModel.dreamsList.append(curDream)
                        coreAppModel.saveANDupload(curDream)
                    }) {
                        Text("Save analysis")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .onChange(of: gemini.jsonOutput, {
            let newDream = gemini.decodeDream()
            curDream.name = newDream?.name
            curDream.content = newDream?.content
            curDream.recentEvents = newDream?.recentEvents
            curDream.savedAnalysis = newDream?.savedAnalysis
            curDream.sentiments = newDream?.sentiments ?? []
            curDream.date = date
        })
    }
}

