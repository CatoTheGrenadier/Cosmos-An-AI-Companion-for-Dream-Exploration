//
//  DreamModel.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestore

class DreamModel: Identifiable, ObservableObject, Codable, Equatable, Comparable {
    var id: String?
    var date: Date?
    var content: String?
    var name: String?
    var sentiments: [String]
    var savedAnalysis: String?
    var recentEvents: String?
    var score: Int?
    
    init(){
        id = UUID().uuidString 
        date = Date()
        content = ""
        name = ""
        sentiments = []
        savedAnalysis = ""
        recentEvents = ""
        score = 0
    }
    
    static func == (lhs: DreamModel, rhs: DreamModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: DreamModel, rhs: DreamModel) -> Bool {
        return lhs.date ?? Date() > rhs.date ?? Date()
    }
}
