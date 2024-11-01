//
// SudokuGenerator.swift
// TheBestSudoku


import Foundation

class SudokuGenerator {
    
    var difficultyLevel: Int
        
    init(difficultyLevel: Int) {
        self.difficultyLevel = difficultyLevel
    }
    
    func getNumbers() -> [[Int]] {
        var finalArray = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        _ = fillSudoku(&finalArray, row: 0, col: 0)
        return finalArray
    }

    func fillSudoku(_ board: inout [[Int]], row: Int, col: Int) -> Bool {
        if row == 9 {
            return true
        }
        
        let nextRow = col == 8 ? row + 1 : row
        let nextCol = (col + 1) % 9
        
        let numbers = Array(1...9).shuffled()
        for num in numbers {
            if isValid(board, row, col, num) {
                board[row][col] = num
                if fillSudoku(&board, row: nextRow, col: nextCol) {
                    return true
                }
                board[row][col] = 0
            }
        }
        return false
    }

    func isValid(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
        
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for i in 0..<3 {
            for j in 0..<3 {
                if board[startRow + i][startCol + j] == num {
                    return false
                }
            }
        }
        return true
    }
    
    
    func deleteSomeNums() -> (arr: [[Int]], arrWithSpace:[[Int]]) {
        let finalArray: [[Int]] = getNumbers()
        var arrayWithSpaces: [[Int]] = finalArray
        
        for i in 0..<arrayWithSpaces.count {
                var indices = Array(0..<arrayWithSpaces[i].count)
                // Перемешиваем индексы и выбираем первые 6
                indices.shuffle()
                let randomIndices = indices.prefix(difficultyLevel)
                
                // Заменяем выбранные элементы на нули
                for index in randomIndices {
                    arrayWithSpaces[i][index] = 0
                }
            }
//        print("finalArray", finalArray)
//        print("arrayWithSpaces", arrayWithSpaces)
        
        return (finalArray, arrayWithSpaces)
    }
    
}
