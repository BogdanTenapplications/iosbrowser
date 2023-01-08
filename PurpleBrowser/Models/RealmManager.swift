//
//  RealmManager.swift
//  PurpleBrowser
//
//  Created by Gwinyai Nyatsoka on 5/1/2023.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private  init() {
        
    }
    
    //MARK: - History
    
    func addHistory(id: String, url: String) {
        do {
            let realm = try Realm()
            let historyURL = RealmHistoryURL(value: ["_id": id, "url": url, "created": Date()])
            try realm.write {
                realm.add(historyURL)
            }
        } catch {
            
        }
    }
    
    func getHistory() -> [HistoryURL] {
        do {
            let realm = try Realm()
            let savedHistoryURLs = realm.objects(RealmHistoryURL.self)
            let historyURLs: [HistoryURL] = savedHistoryURLs.compactMap { history in
                guard let url = URL(string: history.url) else {
                    return nil
                }
                let historyURL = HistoryURL(id: history._id, url: url, created: history.created)
                return historyURL
            }
            return historyURLs
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getHistoryItem(id: String) -> HistoryURL? {
        do {
            let realm = try Realm()
            let savedHistory = realm.object(ofType: RealmHistoryURL.self, forPrimaryKey: id)
            guard let history = savedHistory,
                let url = URL(string: history.url) else {
                return nil
            }
            return HistoryURL(id: history._id, url: url, created: history.created)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getHistoryRealmObject(id: String) -> RealmHistoryURL? {
        do {
            let realm = try Realm()
            let savedHistory = realm.object(ofType: RealmHistoryURL.self, forPrimaryKey: id)
            return savedHistory
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteHistory(id: String) {
        do {
            let realm = try Realm()
            guard let historyURL = getHistoryRealmObject(id: id) else {
                return
            }
            try realm.write {
                realm.delete(historyURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Bookmarks
    
    func addBookmark(url: String) {
        let currentBookmarks = getBookmarks()
        if currentBookmarks.contains(where: { bookmarkURL in
            bookmarkURL.url.absoluteString == url
        }) {
            return
        }
        do {
            let realm = try Realm()
            let bookmarkURL = RealmBookmarkURL(value: ["_id": UUID().uuidString, "url": url, "created": Date()])
            try realm.write {
                realm.add(bookmarkURL)
            }
        } catch {
            
        }
    }
    
    func getBookmarks() -> [BookmarkURL] {
        do {
            let realm = try Realm()
            let savedBookmarkURLs = realm.objects(RealmBookmarkURL.self)
            let bookmarkURLs: [BookmarkURL] = savedBookmarkURLs.compactMap { bookmark in
                guard let url = URL(string: bookmark.url) else {
                    return nil
                }
                let bookmarkURL = BookmarkURL(id: bookmark._id, url: url, created: bookmark.created)
                return bookmarkURL
            }
            return bookmarkURLs
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getBookmarkItem(id: String) -> BookmarkURL? {
        do {
            let realm = try Realm()
            let savedBookmark = realm.object(ofType: RealmBookmarkURL.self, forPrimaryKey: id)
            guard let bookmark = savedBookmark,
                let url = URL(string: bookmark.url) else {
                return nil
            }
            return BookmarkURL(id: bookmark._id, url: url, created: bookmark.created)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getBookmarkRealmObject(id: String) -> RealmBookmarkURL? {
        do {
            let realm = try Realm()
            let savedBookmark = realm.object(ofType: RealmBookmarkURL.self, forPrimaryKey: id)
            return savedBookmark
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteBookmarkURL(id: String) {
        do {
            let realm = try Realm()
            guard let bookmarkURL = getBookmarkRealmObject(id: id) else {
                return
            }
            try realm.write {
                realm.delete(bookmarkURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Notes
    
    func addNote(toURL url: String, text: String) {
        do {
            let realm = try Realm()
            //let note = RealmNote(value: ["id": url, "url": url, "text": text, "createdAt": Date()])
            try realm.write {
                realm.create(RealmNote.self, value: ["id": url, "url": url, "text": text, "createdAt": Date()], update: .modified)
            }
        } catch {
            
        }
    }
    
    func getNote(id: String) -> Note? {
        do {
            let realm = try Realm()
            let savedNote = realm.object(ofType: RealmNote.self, forPrimaryKey: id)
            guard let note = savedNote,
                let url = URL(string: note.url) else {
                return nil
            }
            return Note(id: note.id, url: url, text: note.text, createdAt: note.createdAt)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getNoteRealmObject(id: String) -> RealmNote? {
        do {
            let realm = try Realm()
            let savedNote = realm.object(ofType: RealmNote.self, forPrimaryKey: id)
            return savedNote
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getNotes() -> [Note] {
        do {
            let realm = try Realm()
            let savedNotes = realm.objects(RealmNote.self)
            let notes: [Note] = savedNotes.compactMap { note in
                guard let url = URL(string: note.url) else {
                    return nil
                }
                let note = Note(id: note.id, url: url, text: note.text, createdAt: note.createdAt)
                return note
            }
            return notes
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteNote(id: String) {
        do {
            let realm = try Realm()
            guard let note = getNoteRealmObject(id: id) else {
                return
            }
            try realm.write {
                realm.delete(note)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
