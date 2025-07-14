//
//  CoreAppModel.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import Foundation

class CoreAppModel: Codable, ObservableObject {
    var dreamsList: [DreamModel] = []
    
    func saveANDupload(_ dream: DreamModel, completion: ((Error?) -> Void)? = nil) {
            do {
                try FirestoreMgr.shared.db.collection("dreams").document(dream.id ?? "").setData(from: dream) { error in
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
            FirestoreMgr.shared.db.collection("dreams").order(by: "date", descending: true).getDocuments { snapshot, error in
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
    
    init(){
        downloadDreams()
    }
}

