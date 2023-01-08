//
//  MenuVC.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

protocol MenuVCDelegate: AnyObject {
    func goToHistory()
    func goToTabs()
    func goToBookmarks()
    func goToNotes()
    func addBookmark()
}

class MenuVC: UIViewController {
    
    lazy var menuView: MenuView = {
        let nib = UINib(nibName: "MenuView", bundle: nil).instantiate(withOwner: nil)[0] as! MenuView
        nib.delegate = self
        return nib
    }()
    weak var delegate: ViewControllerDelegate?
    var currentTab: HistoryURL?

    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let menuFrame = CGRect(x: 0, y: viewHeight, width: viewWidth, height: 335)
        menuView.frame = menuFrame
        view.addSubview(menuView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.makeMenuViewAppear()
        }
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(backgroundTap)
        view.isUserInteractionEnabled = true
    }
    
    func makeMenuViewAppear() {
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        UIView.animate(withDuration: 0.25) {
            self.menuView.frame = CGRect(x: 0, y: viewHeight - 335, width: viewWidth, height: 335)
        }
    }
    
    @objc func backgroundTapped() {
        dismiss(animated: true)
    }

}

extension MenuVC: MenuVCDelegate {
    
    func goToNotes() {
        dismiss(animated: true) {
            self.delegate?.showNotes()
        }
    }
    
    func goToBookmarks() {
        dismiss(animated: true) {
            self.delegate?.showBookmarks()
        }
    }
    
    func goToHistory() {
        dismiss(animated: true) {
            self.delegate?.showHistoryVC()
        }
    }
    
    func goToTabs() {
        dismiss(animated: true) {
            self.delegate?.showTabsVC()
        }
    }
    
    func addBookmark() {
        if let currentTab = currentTab {
            RealmManager.shared.addBookmark(url: currentTab.url.absoluteString)
        }
    }
    
}
