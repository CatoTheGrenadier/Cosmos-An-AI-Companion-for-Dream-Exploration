//
//  CoreAppModel.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import Foundation

class CoreAppModel: Codable, ObservableObject {
    var dreamsList: [DreamModel] = []
    var sentimentsSet: Set<String> = []
    var userId: String = UUID().uuidString
    
    func saveANDupload(_ dream: DreamModel, completion: ((Error?) -> Void)? = nil) {
        let docRef = FirestoreMgr.shared.db.collection("AppData").document("users").collection("usersCollection").document(userId).collection("dreams")
        do {
            try docRef.document(dream.id ?? "").setData(from: dream) { error in
                if let error = error {
                    print("❌ Upload error:", error.localizedDescription)
                } else {
                    print("✅ Dream uploaded successfully")
                }
                completion?(error)
            }
        } catch {
            print("❌ Encoding error:", error.localizedDescription)
            completion?(error)
        }
     }
    
    func downloadDreams(completion: (() -> Void)? = nil) {
        let docRef = FirestoreMgr.shared.db.collection("AppData").document("users").collection("usersCollection").document(userId).collection("dreams")
        docRef.order(by: "date", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("❌ Download error:", error.localizedDescription)
                completion?()
                return
            }
            
            guard let docs = snapshot?.documents else {
                print("No dreams found")
                self.dreamsList = []
                completion?()
                return
            }
            
            self.dreamsList = docs.compactMap { try? $0.data(as: DreamModel.self) }
            completion?()
        }
    }
    
    
    func saveANDupload_SentimentsSet(completion: ((Error?) -> Void)? = nil) {
        let docRef = FirestoreMgr.shared.db.collection("AppData").document("sentimentsSet")
        let dataToSave: [String: Any] = [
            "allSentiments": Array(sentimentsSet),
        ]
        
        do {
            try docRef.setData(dataToSave) { error in
                if let error = error {
                    print("❌ Upload error:", error.localizedDescription)
                } else {
                    print("✅ SentimentsSet uploaded successfully")
                }
                completion?(error)
            }
        }
     }
    
    func getSentimentsSet(completion: (() -> Void)? = nil) {
        let docRef = FirestoreMgr.shared.db.collection("AppData")
        docRef.getDocuments { snapshot, error in
            if let error = error {
                print("❌ Download error:", error.localizedDescription)
                completion?()
                return
            }
            
            guard let doc = snapshot?.documents else {
                print("No sentiments found")
                self.sentimentsSet = []
                completion?()
                return
            }
            
            if let sentimentStringArray = doc as? [String] {
                self.sentimentsSet = Set(sentimentStringArray)
            } else {
                print("Warning: SentimentsSet is not valid!")
            }
            
            completion?()
        }
    }
    
    
    
    init(){
        downloadDreams()
        getSentimentsSet()
    }
}

