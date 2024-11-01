//
// Square.swift
// TheBestSudoku


import SwiftUI

struct Square: View {
    
    //    init(selectedNum: Binding<Int>) {
    //        self._selectedNum = selectedNum используется если init и Binding
    //        shuffledNumbers = self.deleteSomeNums()
    //    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .center), count: 9)
    
    @Binding var selectedNum: Int
    @Binding var shuffledNumbersWithSpace: [[Int]]
    @Binding var shuffledNumbers: [[Int]]
    @Binding var errorCount: Int
    @State var cellBackground: Color = Color.white
    @State var selectedColumn: Int? = nil
    @State var selectedRow: Int? = nil
    @Binding var isGameWin: Bool
    @Binding var isGameLose: Bool
    @Binding var difficultyModel: DifficultyModel
    @Binding var timer: Int
    
    var body: some View {
        
        ZStack {
            Group {
                VStack(spacing: 0.0) {
                    ForEach(0..<9) { row in
                        HStack(spacing: 0.0) {
                            ForEach(0..<9) { column in
                                var number = shuffledNumbersWithSpace[row][column]
                                Rectangle()
                                    .stroke(Color.specialBlue)
                                    .frame(width: UIScreen.main.bounds.width / 10, height: UIScreen.main.bounds.width / 10)
                                    .overlay {
                                        if number == 0 {
                                            Text("")
                                                .hidden()
                                        } else {
                                            Text("\(number)")
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    .background(
                                        ((selectedRow == row && selectedColumn == column) && self.selectedNum != 0)
                                        ?
                                        cellBackground
                                        :
                                        Color.white
                                    )
                                    .overlay(alignment: .bottom) {
                                        if row == 2 || row == 5 {
                                            Rectangle()
                                                .frame(height: 2)
                                                .frame(maxWidth: .infinity)
                                                .foregroundStyle(Color.specialBlue)
                                        }
                                    }
                                    .overlay(alignment: .trailing) {
                                        if column == 2 || column == 5 {
                                            Rectangle()
                                                .frame(width: 2, height: UIScreen.main.bounds.width / 10)
                                                .foregroundStyle(Color.specialBlue)
                                        }
                                    }
                                    .disabled(number != 0)
                                    .onTapGesture {
                                        if self.selectedNum != 0 {
                                            self.selectedRow = row
                                            self.selectedColumn = column
                                        }
                                        
                                        if (self.selectedRow == row && self.selectedColumn == column && (shuffledNumbers[row][column] == self.selectedNum)) {
                                            number = selectedNum
                                            shuffledNumbersWithSpace[row][column] = number
                                            cellBackground = .green
                                        }
                                        
                                        if (self.selectedRow == row && self.selectedColumn == column && (shuffledNumbers[row][column] != self.selectedNum)) {
                                            errorCount += 1
                                            cellBackground = .red
                                            
                                            if errorCount == 3 {
                                                isGameLose = true
                                                
                                                let model = GameModelRealm()
                                                model.difficultyName = difficultyModel.name
                                                model.date = Date()
                                                model.time = timer
                                                model.isWin = false
                                                RealmManager.shared.addGame(model)
                                            }
                                        }
                                        
                                        if areArraysIdentical(shuffledNumbers, shuffledNumbersWithSpace) {
                                            isGameWin = true
                                            
                                            let model = GameModelRealm()
                                            model.difficultyName = difficultyModel.name
                                            model.date = Date()
                                            model.time = timer
                                            model.isWin = true
                                            RealmManager.shared.addGame(model)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Square {
    //проверка на то, закончена ли игра путем сверки массивов
    func areArraysIdentical(_ arr1: [[Int]], _ arr2: [[Int]]) -> Bool {
        for i in 0..<arr1.count {
            for j in 0..<arr1.count {
                if arr1[i][j] != arr2[i][j] {
                    return false
                }
            }
        }
        
        return true
    }
}

