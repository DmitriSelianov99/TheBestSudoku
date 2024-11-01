//
// RealmManager.swift
// TheBestSudoku


import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    init(){}
    
    let realm = try! Realm()
    
    func getAllGames() -> Results<GameModelRealm> {
        realm.objects(GameModelRealm.self)
    }
    
    func addGame(_ model: GameModelRealm) {
        try! realm.write {
            realm.add(model)
        }
    }
    
}

class GameModelRealm: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var difficultyName: String
    @Persisted var time: Int
    @Persisted var date: Date
    @Persisted var isWin: Bool
    
    // Используем первичный ключ для Realm
        override static func primaryKey() -> String? {
            return "id"
        }
}
