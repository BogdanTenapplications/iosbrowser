//
//  AddNoteViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //noteTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        //noteTextView.layer.cornerRadius = CGFloat(6)
        //noteTextView.layer.borderWidth = CGFloat(0.5)
        noteTextView.text = "Add note..."
        noteTextView.textColor = UIColor.lightGray
        noteTextView.delegate = self
        if let url = url,
           let savedNote = RealmManager.shared.getNote(id: url.absoluteString) {
            noteTextView.text = savedNote.text
            noteTextView.textColor = UIColor.black
        }
    }

}

extension AddNoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.text = "Add note..."
            textView.textColor = UIColor.lightGray
        } else {
            guard let url = url,
            let text = noteTextView.text else {
                return
            }
            RealmManager.shared.addNote(toURL: url.absoluteString, text: text)
        }
    }
    
}
