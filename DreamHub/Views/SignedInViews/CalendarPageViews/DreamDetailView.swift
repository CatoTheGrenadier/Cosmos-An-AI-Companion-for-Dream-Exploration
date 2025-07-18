//
//  NewDreamView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/4/25.
//

import Foundation
import SwiftUI
import MarkdownUI

struct DreamDetailView: View {
    @State var coreAppModel: CoreAppModel
    var dream: DreamModel

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 12) {
                Text(dream.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                
                SentimentsGridView(dream: dream)
                
                HStack{
                    Text(dream.date.map {
                        DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .short)
                    } ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        if let index = coreAppModel.dreamsList.firstIndex(where: { $0.id == dream.id }) {
                            coreAppModel.dreamsList.remove(at: index)
                            Task {
                                await coreAppModel.deleteDream(dream)
                            }
                            print("Dream removed from local list.")
                        } else {
                            print("Dream not found in local list to remove.")
                        }
                    }, label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.indigo)
                    })
                    .padding(.trailing, 25)
                }
                
                Text(dream.content ?? "")
                    .padding(.top, 8)
                
                Text(dream.recentEvents ?? "")
                    .italic()
                    .padding(.bottom, 8)
                
                ScrollView {
                    Markdown(dream.savedAnalysis ?? "")
                        .padding(.top, 10)
                }
            }
        }
        .padding()
    }
}
