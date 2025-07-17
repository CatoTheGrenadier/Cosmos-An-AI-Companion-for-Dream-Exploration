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

    init(coreAppModel: CoreAppModel, dream: DreamModel) {
        self.coreAppModel = coreAppModel
        self.dream = dream
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(dream.name ?? "")
                .font(.title)
                .fontWeight(.bold)

            Text(dream.date.map {
                DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .short)
            } ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(dream.content ?? "")
                .padding(.top, 8)

            Text(dream.recentEvents ?? "")
                .italic()
                .padding(.bottom, 8)

            SentimentsGridView(dream: dream)

            ScrollView {
                Markdown(dream.savedAnalysis ?? "")
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}
