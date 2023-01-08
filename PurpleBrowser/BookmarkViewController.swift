//
//  BookmarkViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var bookMarkURLs: [BookmarkURL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bookMarkURLs = RealmManager.shared.getBookmarks()
        tableView.dataSource = self
    }

}

extension BookmarkViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarkURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath)
        cell.textLabel?.text = bookMarkURLs[indexPath.row].url.absoluteString
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookmark = bookMarkURLs[indexPath.row]
            RealmManager.shared.deleteBookmarkURL(id: bookmark.id)
            bookMarkURLs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
