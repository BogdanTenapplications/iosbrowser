//
//  NoteModel.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import Foundation
import RealmSwift

struct Note {
    
    let id: String
    let url: URL
    let text: String
    let createdAt: Date
    
}

class RealmNote: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String = ""
    @Persisted var text: String = ""
    @Persisted var createdAt = Date()
    
}
