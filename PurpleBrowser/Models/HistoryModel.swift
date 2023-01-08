//
//  HistoryModel.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 5/1/2023.
//

import Foundation
import RealmSwift

struct HistoryURL {
    let id: String
    let url: URL
    let created: Date
}

class RealmHistoryURL: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var url: String = ""
    @Persisted var created = Date()
}
