import Foundation
import RealmSwift

class Note: Object, Identifiable {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var text: String = "text"
    @Persisted var title: String = "title"
}
