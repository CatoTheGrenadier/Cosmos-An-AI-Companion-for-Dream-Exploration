//
//  CoreAppModel.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import Foundation

class CoreAppModel: ObservableObject {
    @Published var dreamsList: [DreamModel] = []
    var sentimentsSet: Set<String> = []
    var userId: String = ""
    
    init(uid: String) {
        userId = uid
        downloadDreams()
        getSentimentsSet()
    }
    
    func sortBYtime(){
        self.dreamsList.sort()
    }
    
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
    
    func deleteDream(_ dream: DreamModel, completion: ((Error?) -> Void)? = nil) async {
        let docRef = FirestoreMgr.shared.db.collection("AppData").document("users").collection("usersCollection").document(userId).collection("dreams").document(dream.id ?? "")
        do {
            try await docRef.delete()
            print("Document successfully deleted!")
        } catch {
            print("❌ Encoding error:", error.localizedDescription)
            print("Error removing document: \(error.localizedDescription)")
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
            print("✅ Dreams downloaded without error")
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
        let docRef = FirestoreMgr.shared.db.collection("AppData").document("sentimentsSet")
        docRef.getDocument { snapshot, error in
            if let error = error {
                print("❌ Download error:", error.localizedDescription)
                completion?()
                return
            }
            
            guard let doc = snapshot, doc.exists else {
                print("No sentiments found")
                self.sentimentsSet = []
                completion?()
                return
            }
            
            if let sentimentStringArray = doc.data()?["allSentiments"] as? [String] {
                self.sentimentsSet = Set(sentimentStringArray)
                print("✅ SentimentsSet downloaded successfully")
            } else {
                print("Warning: SentimentsSet is not valid!")
            }
            
            completion?()
        }
    }
}

