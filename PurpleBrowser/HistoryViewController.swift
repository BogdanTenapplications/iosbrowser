//
//  HistoryViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var historyURLs: [HistoryURL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        historyURLs = RealmManager.shared.getHistory()
        historyURLs.sort { history1, history2 in
            history1.created > history2.created
        }
        tableView.dataSource = self
    }

}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath)
        cell.textLabel?.text = historyURLs[indexPath.row].url.absoluteString
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let historyToDelete = historyURLs[indexPath.row]
            RealmManager.shared.deleteHistory(id: historyToDelete.id)
            historyURLs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
