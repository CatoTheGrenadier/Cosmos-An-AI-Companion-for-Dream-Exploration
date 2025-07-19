//
//  DreamListRowView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/19/25.
//

import Foundation
import SwiftUI

struct DreamListRowView: View {
    var dream: DreamModel
    @ObservedObject var coreAppModel: CoreAppModel
    
    var body: some View {
        NavigationLink(destination: {
                DreamDetailView(coreAppModel: coreAppModel, dream: dream)
        }, label: {
                HStack(alignment:.center){
                    VStack(alignment: .leading){
                        Text(dream.name ?? "")
                            .fontWeight(.bold)
                        Text(dream.date.map {
                            DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .short)
                        } ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                }
                .frame(height: 30, alignment: .leading)
                .padding(5)
                .alignmentGuide(.listRowSeparatorTrailing) { d in
                    315
                }
            }
        )
    }
}
