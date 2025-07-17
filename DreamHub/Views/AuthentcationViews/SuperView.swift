//
//  PreSignedIn.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import Foundation
import SwiftUI

struct SuperView: View {
    @ObservedObject var authMgr: AuthMgr
    
    var body: some View {
        if authMgr.currentUserUID == nil {
            AuthView(authMgr: authMgr)
        } else {
            SignedInView(authMgr: authMgr)
        }
    }
}
