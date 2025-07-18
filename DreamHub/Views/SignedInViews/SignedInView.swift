//
//  SignedInView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import Foundation
import SwiftUI

struct SignedInView: View {
    @ObservedObject var authMgr: AuthMgr
    @ObservedObject var coreAppModel: CoreAppModel
    @State var page = 1
    @State var date = Date()
    
    init(authMgr: AuthMgr) {
        self.authMgr = authMgr
        self.coreAppModel = CoreAppModel(uid: authMgr.currentUserUID ?? "")
        self.page = page
        self.date = date
    }
    
    var body: some View {
        VStack{
            NavigationStack{
                VStack{
                    if page == 0{
                        CalendarPageView(coreAppModel: coreAppModel)
                    } else if page == 1{
                        GeminiView(coreAppModel: coreAppModel, date: date)
                    } else {
                        GeminiView(coreAppModel: coreAppModel, date: date)
                    }
                }
            }
            
            NavBarView(page: $page, authMgr: authMgr)
        }
    }
}
