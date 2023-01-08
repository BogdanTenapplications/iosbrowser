//
//  ViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 3/1/2023.
//

import UIKit
import WebKit

protocol ViewControllerDelegate: AnyObject {
    func showHistoryVC()
    func showTabsVC()
    func showBookmarks()
    func showNotes()
}

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var emptyStateView: UIView!
    var pageIndex = -1
    var historyUrls: [HistoryURL] = []
    var tabURLs: [TabURL] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabsSegue" {
            let destinationVC = segue.destination as! TabsViewController
            destinationVC.tabURLs = tabURLs
        }
        if segue.identifier == "AddNoteSegue" {
            let destinationVC = segue.destination as! AddNoteViewController
            if pageIndex != -1 {
                let currentPage = historyUrls[pageIndex]
                destinationVC.url = currentPage.url
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    @IBAction func loadWebPage(_ sender: Any) {
        guard let urlText = urlTextField.text,
              let url = URL(string: urlText) else {
                  return
              }
        let historyURL = HistoryURL(id: UUID().uuidString, url: url, created: Date())
        let request = URLRequest(url: url)
        if pageIndex == historyUrls.count - 1 {
            let tabURL = TabURL(url: url, created: Date())
            tabURLs.append(tabURL)
            pageIndex += 1
            historyUrls.append(historyURL)
        }
        RealmManager.shared.addHistory(id: historyURL.id, url: url.absoluteString)
        webView.load(request)
    }
    
    @IBAction func previousPage(_ sender: Any) {
        let lastIndex = pageIndex - 1
        if historyUrls.indices.contains(lastIndex) {
            pageIndex = lastIndex
            let lastRequest = historyUrls[lastIndex]
            let urlRequest = URLRequest(url: lastRequest.url)
            webView.load(urlRequest)
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        let nextIndex = pageIndex + 1
        if historyUrls.indices.contains(nextIndex) {
            pageIndex = nextIndex
            let nextRequest = historyUrls[nextIndex]
            let urlRequest = URLRequest(url: nextRequest.url)
            webView.load(urlRequest)
        } else {
            print("index not found")
        }
    }
    
    @IBAction func addNoteButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddNoteSegue", sender: nil)
    }
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        let menuViewController = MenuVC()
        if pageIndex != -1 {
            menuViewController.currentTab = historyUrls[pageIndex]
        }
        menuViewController.delegate = self
        present(menuViewController, animated: true)
    }
    
    

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        emptyStateView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        emptyStateView.isHidden = true
    }
    
}

extension ViewController: ViewControllerDelegate {
    
    func showHistoryVC() {
        performSegue(withIdentifier: "ShowHistorySegue", sender: nil)
    }
    
    func showTabsVC() {
        performSegue(withIdentifier: "ShowTabsSegue", sender: nil)
    }
    
    func showBookmarks() {
        performSegue(withIdentifier: "ShowBookmarksSegue", sender: nil)
    }
    
    func showNotes() {
        performSegue(withIdentifier: "ShowNotesSegue", sender: nil)
    }
    
}

