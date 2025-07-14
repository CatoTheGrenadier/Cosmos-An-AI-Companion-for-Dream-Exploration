//
//  DreamModel.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestore

class DreamModel: Identifiable, ObservableObject, Codable {
    var id: String?
    var date: Date?
    var content: String?
    var name: String?
    var sentiments: [String]
    var savedAnalysis: String?
    var recentEvents: String?
    
    init(){
        id = UUID().uuidString 
        date = Date()
        content = ""
        name = ""
        sentiments = []
        savedAnalysis = ""
        recentEvents = ""
    }
}
