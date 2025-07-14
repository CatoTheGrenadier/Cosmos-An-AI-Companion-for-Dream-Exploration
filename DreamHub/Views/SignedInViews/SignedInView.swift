//
//  SignedInView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import Foundation
import SwiftUI

struct SignedInView: View {
    @ObservedObject var coreAppModel = CoreAppModel()
    @State var page = 2
    @State var date = Date()
    
    var body: some View {
        VStack{
            NavigationStack{
                VStack{
                    if page == 0{
                        CalendarPageView(coreAppModel: coreAppModel)
                    } else if page == 1{
                        NewDreamView(coreAppModel: coreAppModel, date: date)
                    } else {
                        GeminiView(coreAppModel: coreAppModel, date: date)
                    }
                }
            }
            
            NavBarView(page: $page)
        }
    }
}
