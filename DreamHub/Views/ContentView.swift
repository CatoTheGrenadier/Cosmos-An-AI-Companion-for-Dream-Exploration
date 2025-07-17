//
//  ContentView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authMgr = AuthMgr()
    
    var body: some View {
        SuperView(authMgr: authMgr)
    }
}

#Preview {
    ContentView()
}
