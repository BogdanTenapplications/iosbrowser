//
//  NotesViewController.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 6/1/2023.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var notes: [Note] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewNoteSegue" {
            let destinationVC = segue.destination as! AddNoteViewController
            let selectedNote = sender as! Note
            destinationVC.url = selectedNote.url
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmManager.shared.getNotes()
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].url.absoluteString
        cell.detailTextLabel?.text = notes[indexPath.row].text
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            RealmManager.shared.deleteNote(id: note.id)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "ViewNoteSegue", sender: selectedNote)
    }
    
}
