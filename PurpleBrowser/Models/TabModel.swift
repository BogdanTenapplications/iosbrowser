//
//  TabModel.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import Foundation
import WebKit

struct TabURL {
    let url: URL
    let created: Date
    var tabIndex: Int
    var tabView: WKWebView
}
