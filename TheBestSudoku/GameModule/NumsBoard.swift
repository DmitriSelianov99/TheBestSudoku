//
// NumsBoard.swift
// TheBestSudoku


import SwiftUI

struct NumsBoard: View {
    @Binding var selectedNum: Int
    @Binding var numsArray: [[Int]]
    
    var body: some View {
        
        VStack {
            NumsLine(selectedNum: $selectedNum, numsArray: $numsArray, countNumbers: countNumbers, range: 1..<6)
            NumsLine(selectedNum: $selectedNum, numsArray: $numsArray, countNumbers: countNumbers, range: 6..<10)
        }
    }
}

extension NumsBoard {
    func countNumbers(array: [[Int]], num: Int) -> Int {
        var counter = 0
        for i in array {
            for x in i {
                if x == num {
                    counter += 1
                }
            }
        }
        
        return counter
    }
}

struct NumsLine: View {
    
    @Binding var selectedNum: Int
    @Binding var numsArray: [[Int]]
    var countNumbers: ([[Int]], Int) -> Int
    let range: Range<Int>
    
    var body: some View {
        HStack {
            ForEach(Array(range), id: \.self) { num in
                let numCounter = 9 - countNumbers(numsArray, num)
                VStack(spacing: -5) {
                    Text("\(num)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedNum == num ? Color.specialYellow : .specialBlue)
                        .frame(width: 40, height: 40)
                        .background(selectedNum == num ? Color.specialBlue : Color.specialYellow)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            if selectedNum == num {
                                selectedNum = 0
                            } else {
                                selectedNum = num
                            }
                        }
                        .disabled(numCounter == 0)
                        .zIndex(1)
                    
                    Text("\(numCounter)")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 20)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .background(Color.specialYellow.opacity(0.5))
                }
                .opacity(numCounter == 0 ? 0 : 1)
            }
        }
    }
}
