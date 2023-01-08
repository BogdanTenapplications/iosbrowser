//
//  TabsViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

class TabsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tabURLs: [TabURL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

}

extension TabsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TabTableViewCell", for: indexPath)
        cell.textLabel?.text = tabURLs[indexPath.row].url.absoluteString
        return cell
    }
    
}
