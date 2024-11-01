//
// StatisticsView.swift
// TheBestSudoku


import SwiftUI
import Charts
import RealmSwift

struct StatisticsView: View {
    
    var games: Results<GameModelRealm>
    var gamesForChart: [GameModelRealm]
    var winsAndLosses: [String: (wins: Int, losses: Int)] = [:]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.specialBlue]
        games = RealmManager.shared.getAllGames()
        gamesForChart = games.sorted { first, second in
            first.time > second.time
        }
        
        // Группируем игры по уровню сложности и считаем количество выигрышей и проигрышей
        for game in games {
            let key = game.difficultyName
            if winsAndLosses[key] == nil {
                winsAndLosses[key] = (wins: 0, losses: 0)
            }
            if game.isWin {
                winsAndLosses[key]?.wins += 1
            } else {
                winsAndLosses[key]?.losses += 1
            }
        }
    }
    
//    let games = RealmManager.shared.getAllGames()
//    let gamesForChart = games.sorted { first, second in
//        first.time > second.time
//    }
    let format = FormattedFunctions.shared
    
    var body: some View {
        VStack {
            NavigationStack {
                List(games) { game in
                    HStack {
                        Text("\(game.difficultyName)")
                        Spacer()
                        Text("\(format.formatTime(game.time))")
                        Spacer()
                        Text("\(format.formatDate(game.date))")
                    }
                    .foregroundStyle(game.isWin ? Color.green : Color.red)
                }
                //            .padding(.top, 10)
                .navigationTitle("statistics")
                .scrollContentBackground(.hidden)
                .background(Color.gameBackground)
            }
            
            Chart {
                // Сортируем ключи по возрастанию сложности
                let sortedKeys = Array(winsAndLosses.keys).sorted { difficultyOrder($0) < difficultyOrder($1) }
                
                ForEach(sortedKeys, id: \.self) { difficulty in
                    if let result = winsAndLosses[difficulty] {
                        BarMark(
                            x: .value("Difficulty", difficulty),
                            y: .value("Wins", result.wins)
                        )
                        .foregroundStyle(Color.green)
                        .position(by: .value("Type", "Wins"))  // Используем позиционирование
                        .annotation {
                            Text("\(result.wins)")
                                .foregroundColor(.green)
                        }
                        
                        BarMark(
                            x: .value("Difficulty", difficulty),
                            y: .value("Losses", result.losses)
                        )
                        .foregroundStyle(Color.red)
                        .position(by: .value("Type", "Losses"))  // Используем позиционирование
                        .annotation {
                            Text("\(result.losses)")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .frame(height: 300)
            .padding()
//            .chartXAxis {
//                AxisMarks() {
//                    AxisGridLine().foregroundStyle(Color.black)  // Цвет линий оси X
//                    AxisTick().foregroundStyle(Color.black)      // Цвет делений оси X
//                    AxisValueLabel().font(.system(size: 15, weight: .bold, design: .default))
//                    AxisValueLabel().foregroundStyle(Color.purple) // Цвет меток оси X
//                }
//            }
//            .chartYAxis {
//                AxisMarks() {
//                    AxisGridLine().foregroundStyle(Color.black)  // Цвет линий оси Y
//                    AxisTick().foregroundStyle(Color.black)      // Цвет делений оси Y
//                    AxisValueLabel().foregroundStyle(Color.purple) // Цвет меток оси Y
//                }
//            }
        }
        .background(Color.gameBackground)
        

    }
}

extension StatisticsView {
    private func difficultyOrder(_ difficulty: String) -> Int {
            switch difficulty {
            case "EASY":
                return 1
            case "MEDIUM":
                return 2
            case "HARD":
                return 3
            case "EXPERT":
                return 4
            default:
                return 5
            }
        }
}

#Preview {
    StatisticsView()
}
