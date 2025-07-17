//
//  ContentView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @State var isSignedIn = true
    @ObservedObject var authMgr = AuthMgr()
    var body: some View {
        if (isSignedIn){
            SignedInView(authMgr: authMgr)
        } else {
            PreSignedInView(authMgr: authMgr)
        }
    }
}

#Preview {
    ContentView()
}
