//
//  MenuView.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 5/1/2023.
//

import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var historyMenuItem: UIView!
    @IBOutlet weak var tabsMenuItem: UIView!
    @IBOutlet weak var bookMarksMenuItem: UIView!
    @IBOutlet weak var notesMenuItem: UIView!
    @IBOutlet weak var addBookmarkItem: UIView!
    weak var delegate: MenuVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addMenuDestinations()
    }
    
    func addMenuDestinations() {
        let historyMenuTap = UITapGestureRecognizer(target: self, action: #selector(historyMenuItemTapped))
        historyMenuItem.addGestureRecognizer(historyMenuTap)
        historyMenuItem.isUserInteractionEnabled = true
        let tabsMenuTap = UITapGestureRecognizer(target: self, action: #selector(tabsMenuItemTapped))
        tabsMenuItem.addGestureRecognizer(tabsMenuTap)
        tabsMenuItem.isUserInteractionEnabled = true
        let bookMarksMenuTap = UITapGestureRecognizer(target: self, action: #selector(bookMarksItemTapped))
        bookMarksMenuItem.addGestureRecognizer(bookMarksMenuTap)
        bookMarksMenuItem.isUserInteractionEnabled = true
        let notesMenuTap = UITapGestureRecognizer(target: self, action: #selector(notesMenuItemTapped))
        notesMenuItem.addGestureRecognizer(notesMenuTap)
        notesMenuItem.isUserInteractionEnabled = true
        let addBookMarksMenuTap = UITapGestureRecognizer(target: self, action: #selector(addBookmarkItemTapped))
        addBookmarkItem.addGestureRecognizer(addBookMarksMenuTap)
        addBookmarkItem.isUserInteractionEnabled = true
    }
    
    @objc func historyMenuItemTapped() {
        delegate?.goToHistory()
    }
    
    @objc func tabsMenuItemTapped() {
        delegate?.goToTabs()
    }
    
    @objc func bookMarksItemTapped() {
        delegate?.goToBookmarks()
    }
    
    @objc func notesMenuItemTapped() {
        delegate?.goToNotes()
    }
    
    @objc func addBookmarkItemTapped() {
        delegate?.addBookmark()
    }

}
