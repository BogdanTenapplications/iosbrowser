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
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var emptyStateView: UIView!
    var pageIndex = -1
    var historyUrls: [HistoryURL] = []
    var tabURLs: [TabURL] = []
    var currentWebView: WKWebView?
    
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
        urlTextField.delegate = self
        emptyStateView.isHidden = true
    }
    
    @IBAction func loadWebPage(_ sender: Any) {
        guard let urlText = urlTextField.text,
              let url = URL(string: urlText) else {
                  return
              }
        view.endEditing(true)
        loadWebPageInCurrentTab(url: url)
    }
    
    func loadWebPageInCurrentTab(url: URL) {
        let historyURL = HistoryURL(id: UUID().uuidString, url: url, created: Date())
        let request = URLRequest(url: url)
        if pageIndex == tabURLs.count - 1 || tabURLs.count == 0 {
            let webView = WKWebView()
            
            webView.navigationDelegate = self
            currentWebView = webView
            layout(webView: webView)
            let tabURL = TabURL(url: url, created: Date(), tabIndex: pageIndex, tabView: webView)
            tabURLs.append(tabURL)
            pageIndex += 1
            historyUrls.append(historyURL)
            webView.load(request)
            RealmManager.shared.addHistory(id: historyURL.id, url: url.absoluteString)
        }
    }
    
    @IBAction func previousPage(_ sender: Any) {
        let lastIndex = pageIndex - 1
        if tabURLs.indices.contains(lastIndex) {
            pageIndex = lastIndex
            currentWebView = tabURLs[lastIndex].tabView
            layout(webView: tabURLs[lastIndex].tabView)
        }
    }
    
    func layout(webView: WKWebView) {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webViewContainer.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor),
            webView.leadingAnchor.constraint(equalTo: webViewContainer.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: webViewContainer.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor)
        ])
    }
    
    @IBAction func nextPage(_ sender: Any) {
        let nextIndex = pageIndex + 1
        if tabURLs.indices.contains(nextIndex) {
            pageIndex = nextIndex
            currentWebView = tabURLs[nextIndex].tabView
            layout(webView: tabURLs[nextIndex].tabView)
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

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let urlText = urlTextField.text,
              let url = URL(string: urlText) else {
            textField.resignFirstResponder()
                  return false
              }
        textField.resignFirstResponder()
        loadWebPageInCurrentTab(url: url)
        return true
    }
    
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        emptyStateView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        emptyStateView.isHidden = true
        if pageIndex == tabURLs.count - 1 {
            var tab = tabURLs[pageIndex]
            tab.tabView = webView
            tab.tabIndex = pageIndex
        }
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

