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
                    if gemini.isLoading {
                         VStack{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                            Text("AI is thinking...")
                                .font(.title)
                                .foregroundStyle(.indigo)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 250)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 185)
                    } else {
                        ScrollView{
                            VStack(alignment: .leading, spacing: 20){
                                Text(curDream.name ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                SentimentsGridView(dream: curDream)
                                Markdown(curDream.savedAnalysis ?? "")
                            }
                            .padding(.horizontal,25)
                        }
                    }
                }
            
            VStack{
                DreamTextFieldView(value1: $userInputDream, value2:$userInputIrlEvents)
            }
            .padding()
            
            HStack{
                Button(action: {
                    unClicked = false
                    gemini.dreamContent = userInputDream
                    gemini.irlEvents = userInputIrlEvents
                    let sentiments_string = "[" + coreAppModel.sentimentsSet.joined(separator: ", ") + "]"
                    gemini.assembleFinalPrompt(sentimentsString: sentiments_string)
                    gemini.generateResponse()
                    userInputDream = ""
                    userInputIrlEvents = ""
                }) {
                    Text("Interprete")
                        .padding()
                        .frame(width: 160, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                .padding(.trailing, 20)
                
                
                if (gemini.isLoading || unClicked){
                    Button(action: {
                        
                    }) {
                        Text("Save")
                            .padding()
                            .frame(width: 160, height: 50)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        coreAppModel.dreamsList.append(curDream)
                        for sentimentString in curDream.sentiments {
                            coreAppModel.sentimentsSet.insert(sentimentString)
                        }
                        coreAppModel.saveANDupload(curDream)
                        coreAppModel.saveANDupload_SentimentsSet()
                    }) {
                        Text("Save")
                            .padding()
                            .frame(width: 160, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .onChange(of: gemini.jsonOutput, {
            if gemini.jsonOutput != "{}" {
                let newDream = gemini.decodeDream()
                curDream.name = newDream?.name
                curDream.content = newDream?.content
                curDream.recentEvents = newDream?.recentEvents
                curDream.savedAnalysis = newDream?.savedAnalysis
                curDream.sentiments = newDream?.sentiments ?? []
                curDream.date = date
                print("onChange finished")
            }
        })
    }
}

