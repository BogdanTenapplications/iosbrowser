//
//  BookmarkModel.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import Foundation
import RealmSwift

struct BookmarkURL {
    let id: String
    let url: URL
    let created: Date
}

class RealmBookmarkURL: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var url: String = ""
    @Persisted var created = Date()
}
