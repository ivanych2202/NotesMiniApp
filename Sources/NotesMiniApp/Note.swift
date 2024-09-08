import Foundation
import RealmSwift

class Note: Object, Identifiable {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted public var text: String = "text"
    
    public override init() {
        super.init()
    }
}
