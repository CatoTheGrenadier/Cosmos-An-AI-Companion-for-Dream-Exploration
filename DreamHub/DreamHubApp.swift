//
//  DreamHubApp.swift
//  DreamHub
//
//  Created by Yi Ling on 6/26/25.
//

import SwiftUI

@main
struct DreamHubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
