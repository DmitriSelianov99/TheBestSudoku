//
// ContentView.swift
// TheBestSudoku


import SwiftUI

struct StartView: View {
    
    @AppStorage("isStartingGame") var isStartingGame: Bool = false
    @AppStorage("unsavedTimer") var unsavedTimer: Int = 0
    @AppStorage("unsavedErrors") var unsavedErrors: Int = 0
    @AppStorage("unsavedNumsArrays") var unsavedNumsArrays: Data?
    @AppStorage("unsavedLevelName") var unsavedLevelName: String = ""
    
    @StateObject var difficultyViewModel = DifficultyViewModel()
    @State var isPresentedGame: Bool = false
    @State var isPresentedUnsavedGame: Bool = false
    @State var selectedModel: DifficultyModel? = nil
    @State var decodedArrays: UnsavedArrays?
    @State var isLoading: Bool = false //загурзка данных
    
    init(){}
    
    var body: some View {
        ZStack {
            
            Color.gameBackground.ignoresSafeArea()
            
            VStack {
                Text("choose_A_Level")
                    .font(.title2)
                    .bold()
                    .padding(.top, 50)
                    .foregroundStyle(Color.specialBlue)
                
                Spacer()
                
                LevelsView(difficultyViewModel: difficultyViewModel, selectedModel: $selectedModel, isPresentedGame: $isPresentedGame)
                
//                if isStartingGame {
//                    Button("continue_game") {
//                        isPresentedUnsavedGame = true
//                    }
//                    .foregroundColor(Color.specialBlue)
//                    .font(.headline)
//                    .frame(width: 150)
//                    .padding()
//                    .background(Color.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
//                    .opacity(isStartingGame ? 1 : 0)
//                    .disabled(isStartingGame ? false : true)
//                    .sheet(isPresented: $isPresentedUnsavedGame) {
//                        if isLoading {
//                            // Показываем индикатор загрузки, пока данные не загружены
//                            ProgressView("Loading game...")
//                        } else if let unsavedArrays = decodedArrays {
//                            GameView(
//                                difficultyModel: difficultyViewModel.getModelByName(name: unsavedLevelName)!,
//                                errorCount: $unsavedErrors,
//                                timer: $unsavedTimer,
//                                unsavedArrays: unsavedArrays
//                            )
//                        } else {
//                            // Если данные так и не загрузились
//                            Text("Error loading game.")
//                        }
//                    }
//                }
                
                Spacer()
                Spacer()
                
                BottomView()
            }
        }
        .onAppear {
            // Отладочная проверка данных
            if let data = unsavedNumsArrays {
                print("Data found in AppStorage:", data) // Выводим данные перед декодированием
                
                isLoading = true // устанавливаем состояние загрузки
                
                // Попробуем декодировать данные
                if let decoded = UnsavedArrays.decode(from: data) {
                    decodedArrays = decoded
                    isLoading = false // загрузка завершена
                    print("Decoded arrays successfully:", decodedArrays!)
                } else {
                    print("Error decoding arrays")
                    isLoading = false
                }
            } else {
                print("ERROR WITH DECODED: No data found in AppStorage")
            }
        }
    }
}


#Preview {
    StartView()
}

