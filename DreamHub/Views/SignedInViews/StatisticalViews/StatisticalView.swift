//
//  StatisticalView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/19/25.
//

import Foundation
import SwiftUI
import Charts

struct StatisticalView: View {
    @ObservedObject var coreAppModel: CoreAppModel
    
    var body: some View {
        ScrollView{
            VStack{
                Chart {
                    ForEach(coreAppModel.dateScoresDict.sorted(by: { $0.key < $1.key }), id: \.key) { dayKey, scoresArray in
                        let avgScore = scoresArray.reduce(0, +) / Double(scoresArray.count)
                        LineMark(
                            x: .value("Date", dayKey),
                            y: .value("Mood Score", avgScore)
                        )
                        
                        PointMark(
                            x: .value("Date", dayKey),
                            y: .value("Mood Score", avgScore)
                        )
                    }
                }
                .frame(width:300, height: 200)
            }
            .padding()
        }
        .onAppear{
            print("Augustus")
            print(coreAppModel.dreamsList)
            coreAppModel.calculateDailyMoodScore()
        }
    }
}
