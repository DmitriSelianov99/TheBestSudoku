//
// FormattedFunctions.swift
// TheBestSudoku


import Foundation

class FormattedFunctions {
    static let shared = FormattedFunctions()
    
    private init(){}
    
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        
        // Форматирование строки времени
        let formattedTime = String(format: "%d:%02d", minutes, seconds)
        
        return formattedTime
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}
