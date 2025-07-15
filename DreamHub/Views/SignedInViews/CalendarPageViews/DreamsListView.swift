//
//  DreamCalendar.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import Foundation
import SwiftUI

struct DreamsListView: View {
    @ObservedObject var coreAppModel: CoreAppModel
    @State var date: Date

    private var filteredDreams: [DreamModel] {
        return coreAppModel.dreamsList.filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date)
        }
    }
    
    var body: some View {
        NavigationStack{
            ForEach(self.filteredDreams) { dream in
                NavigationLink(destination: DreamDetailView(coreAppModel:coreAppModel ,dream: dream)) {
                   HStack(spacing: 8) {
                       Rectangle()
                           .fill(Color.blue)
                           .frame(width: 4, height: 20)
                       Text(dream.content ?? "")
                           .foregroundColor(.black)
                       Spacer()
                   }
               }
            }
        }
    }
}
