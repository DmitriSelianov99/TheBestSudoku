//
// GameModel.swift
// TheBestSudoku


import Foundation
import RealmSwift

struct GameModel: Identifiable {
    let id: String = UUID().uuidString
    let difficultyName: String
    let time: Int
    let date: Date
}

class GameModelViewModel {
    
}

struct UnsavedGame {
    let difficultyModel: DifficultyModel
    let errorCount: Int
    let timer: Int
    let arrayOfArrays: ([[Int]], [[Int]])
    
//    // Пример функции кодирования
//    func encode() -> Data? {
//        let encoder = JSONEncoder()
//        return try? encoder.encode(self)
//    }
//
//    // Пример функции декодирования
//    static func decode(from data: Data) -> GameModelRealm? {
//        let decoder = JSONDecoder()
//        return try? decoder.decode(GameModelRealm.self, from: data)
//    }
}

struct UnsavedArrays: Codable {
    let array: [[Int]]
    let arrayWithSpace: [[Int]]
    
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    static func decode(from data: Data?) -> UnsavedArrays? {
        guard let data = data else { return nil }
        print("SUCCESS GET DATA")
        let decoder = JSONDecoder()
        return try? decoder.decode(UnsavedArrays.self, from: data)
    }
}


