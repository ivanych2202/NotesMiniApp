import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    
    private var realm: Realm
    private var notes: Results<Note>?
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
            self.realm = try! Realm()
        }
    }
        
    func addNewNote(note: Note) {
        do {
            try realm.write {
                realm.add(note)
            }
        } catch {
            print("Error adding new note to Realm: \(error)")
        }
    }
    
    func editNote(note: Note, newTitle: String, newText: String) {
        do {
            try realm.write {
                note.title = newTitle
                note.text = newText
            }
        } catch {
            print("Error editing note in Realm: \(error)")
        }
    }
    
    func deleteNote(note: Note) {
        do {
            try realm.write {
                realm.delete(note)
            }
        } catch {
            print("Error deleting note from Realm: \(error)")
        }
    }
    
    func getAllNotes() -> Results<Note> {
        return realm.objects(Note.self)
    }
    
    func getNoteById(id: String) -> Note? {
        return realm.object(ofType: Note.self, forPrimaryKey: id)
    }
    
    func fetchNotes() {
        notes = realm.objects(Note.self)
    }

}
