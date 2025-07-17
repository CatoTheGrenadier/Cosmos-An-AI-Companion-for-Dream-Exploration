//
//  FirestoreDBMgr.swift
//  DreamHub
//
//  Created by Yi Ling on 7/13/25.
//

import Foundation
import FirebaseFirestore

class FirestoreMgr {
    static let shared = FirestoreMgr()
    let db = Firestore.firestore()
    private init() {}
}

