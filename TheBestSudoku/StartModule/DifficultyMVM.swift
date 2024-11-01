//
// DifficultyMVM.swift
// TheBestSudoku


import Foundation
import SwiftUI

struct DifficultyModel: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let name: String
    let clearSquares: Int
    let color: Color
}

class DifficultyViewModel: ObservableObject {
    @Published var difficultyArray: [DifficultyModel] = [
        DifficultyModel(name: "EASY", clearSquares: 3, color: .specialGreen),
        DifficultyModel(name: "MEDIUM", clearSquares: 5, color: .specialYellow),
        DifficultyModel(name: "HARD", clearSquares: 7, color: .specialRed),
        DifficultyModel(name: "EXPERT", clearSquares: 8, color: .black),
    ]
    
    func getModelByName(name: String) -> DifficultyModel? {
        return difficultyArray.first { $0.name == name}
    }
}
