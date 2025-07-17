//
//  UserModel.swift
//  DreamHub
//
//  Created by Yi Ling on 7/17/25.
//

import Foundation

class User: Identifiable {
    let id: String
    let email: String?
    let displayedName: String?
    
    init(id: String, email: String?, displayedName: String?) {
        self.id = id
        self.email = email
        self.displayedName = displayedName
    }
}
