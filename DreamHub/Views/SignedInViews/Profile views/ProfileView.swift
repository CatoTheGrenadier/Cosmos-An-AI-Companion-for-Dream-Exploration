//
//  ProfileView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/18/25.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var coreAppModel: CoreAppModel
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(self.coreAppModel.dreamsList) { dream in
                    ZStack{
                        HStack{
                            Text(dream.name ?? "")
                        }
                        .frame(height: 50, alignment: .leading)
                        .padding()
                        
                        NavigationLink(destination: {
                            DreamDetailView(coreAppModel: coreAppModel, dream: dream)
                        }, label: {
                            EmptyView()
                        })
                    }
                    .swipeActions {
                        Button(action: {
                            if let index = coreAppModel.dreamsList.firstIndex(where: { $0.id == dream.id }) {
                                Task {
                                    coreAppModel.dreamsList.remove(at: index)
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
                                .foregroundStyle(.white)
                        })
                        .padding(.trailing, 25)
                    }
                    .tint(.red)
                }
            }
        }
    }
}
