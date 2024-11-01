//
// LevelsView.swift
// TheBestSudoku


import SwiftUI

struct LevelsView: View {
    
    @AppStorage("isStartingGame") var isStartingGame: Bool = false
    
    @ObservedObject var difficultyViewModel: DifficultyViewModel
    @Binding var selectedModel: DifficultyModel?
    @Binding var isPresentedGame: Bool
    
    @State var  errorCount: Int = 0
    @State var timer: Int = 0
    
    var body: some View {
        if #available(iOS 17, *) {
            VStack {
                ForEach(difficultyViewModel.difficultyArray) { difficulty in
                    Button(difficulty.name) {
                        selectedModel = difficulty
                        isStartingGame = false
                    }
                    .foregroundStyle(.specialBlue)
                    .font(.headline)
                    .frame(width: 150)
                    .padding()
                    .background(difficulty.color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .onChange(of: selectedModel, { _, newValue in
                    if newValue != nil {
                        isPresentedGame = true
                    }
                })
                .fullScreenCover(isPresented: $isPresentedGame, onDismiss: {
                    // Сбрасываем выбранную модель сложности, чтобы можно было начать заново
                    selectedModel = nil
                }, content: {
                    if let selectedModel = selectedModel {
                        GameView(difficultyModel: selectedModel)
                    } else {
                        Text("No difficulty selected")
                    }
                })
            }
        } else {
            VStack {
                ForEach(difficultyViewModel.difficultyArray) { difficulty in
                    Button(difficulty.name) {
                        selectedModel = difficulty
                        isStartingGame = false
                    }
                    .foregroundStyle(.specialBlue)
                    .font(.headline)
                    .frame(width: 150)
                    .padding()
                    .background(difficulty.color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .onChange(of: selectedModel) { newValue in
                    if newValue != nil {
                        isPresentedGame = true
                    }
                }
                .fullScreenCover(isPresented: $isPresentedGame, onDismiss: {
                    // Сбрасываем выбранную модель сложности, чтобы можно было начать заново
                    selectedModel = nil
                }, content: {
                    if let selectedModel = selectedModel {
                        GameView(difficultyModel: selectedModel)
                    } else {
                        Text("No difficulty selected")
                    }
                })
            }
        }
    }
}
