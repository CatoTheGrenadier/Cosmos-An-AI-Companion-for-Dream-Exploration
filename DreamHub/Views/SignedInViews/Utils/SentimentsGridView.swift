//
//  SentimentsGridView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation
import SwiftUI
import RomanNumeralKit

struct SentimentsGridView: View {
    var dream: DreamModel
    var renderedSentiment: [String] = []
    
    init(dream: DreamModel) {
        self.dream = dream
        self.renderedSentiment = []
        for senti in dream.sentiments {
            let strength = Int(String(senti.last ?? "1"))
            var temp = String(senti.dropLast(2)) + " " + (strength?.romanNumeral?.stringValue ?? "I")
            self.renderedSentiment.append(temp)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Show sentiments 3 per row
            let sentiments = renderedSentiment
            let chunkedIndexes = stride(from: 0, to: sentiments.count, by: 3).map { $0 }

            ForEach(chunkedIndexes, id: \.self) { i in
                let row = Array(sentiments[i..<min(i + 3, sentiments.count)])
                HStack {
                    ForEach(row, id: \.self) { st in
                        Text(st)
                            .padding(6)
                            .background(Color.blue.opacity(0.15))
                            .cornerRadius(6)
                    }
                }
            }
        }
    }
}
