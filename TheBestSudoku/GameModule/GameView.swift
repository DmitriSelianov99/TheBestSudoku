//
// GameView.swift
// TheBestSudoku
import SwiftUI

struct GameView: View {
    
    @AppStorage("isStartingGame") var isStartingGame: Bool = false
    @AppStorage("unsavedTimer") var unsavedTimer: Int = 0
    @AppStorage("unsavedErrors") var unsavedErrors: Int = 0
    @AppStorage("unsavedNumsArrays") var unsavedNumsArrays: Data?
    @AppStorage("unsavedLevelName") var unsavedLevelName: String = ""
    

    @State var selectedNum: Int = 0
    @State var arrayOfArrays: ([[Int]], [[Int]])
    @State var difficultyModel: DifficultyModel
    @State var isGameWin: Bool = false
    @State var isGameLose: Bool = false
    @State var showAlert: Bool = false
    
    @State var errorCount: Int = 0
    @State var timer: Int = 0
    @Environment(\.dismiss) var dismiss
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .center), count: 3)
    
    
//    init(difficultyModel: DifficultyModel, errorCount: Binding<Int>, timer: Binding<Int>, unsavedArrays: UnsavedArrays?) {
//        self._difficultyModel = State(initialValue: difficultyModel)
//        if unsavedArrays == nil {
//            let arrays = SudokuGenerator(difficultyLevel: difficultyModel.clearSquares).deleteSomeNums()
//            self._arrayOfArrays = State(initialValue: arrays)
//        } else {
//            self._arrayOfArrays = State(initialValue: (unsavedArrays!.array, unsavedArrays!.arrayWithSpace))
//        }
//        
//        self._errorCount = errorCount
//        self._timer = timer
//        
//        let unsavedArays2 = UnsavedArrays(array: arrayOfArrays.0, arrayWithSpace: arrayOfArrays.1)
//        print("INIT \nunsavedArays \(unsavedArays2) \nunsavedTimer \(unsavedTimer) \nunsavedErrors \(unsavedErrors)")
//    }
    
    init(difficultyModel: DifficultyModel) {
        self._difficultyModel = State(initialValue: difficultyModel)
        
        let arrays = SudokuGenerator(difficultyLevel: difficultyModel.clearSquares).deleteSomeNums()
        self._arrayOfArrays = State(initialValue: arrays)
    }

    
    var body: some View {
        ZStack {
            Color.gameBackground.ignoresSafeArea()
            
            VStack {
                HStack(alignment: .top) {
                    Button(action: {
                        showAlert.toggle()
                        
                    }, label: {
                        Image(systemName: "arrowshape.left.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    .foregroundStyle(.specialBlue)
                    .alert(isPresented: $showAlert) {
                        getAlert()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("TheBestSudoku")
                            .font(.title)
                        
                        Text(String(format: NSLocalizedString("level", comment: ""), "\(difficultyModel.name)"))
                            .font(.title3)
                    }
                    .bold()
                    .foregroundStyle(Color.specialBlue)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 30, height: 30)
                        .hidden()
                }
                .padding(.horizontal)
                
                Spacer()
                HStack {
                    ErrorsView(error: $errorCount)
                    Spacer()
                    TimerView(time: $timer)
                }
                .padding(.horizontal)
                
                Square(selectedNum: $selectedNum, 
                       shuffledNumbersWithSpace: $arrayOfArrays.1,
                       shuffledNumbers: $arrayOfArrays.0,
                       errorCount: $errorCount,
                       isGameWin: $isGameWin,
                       isGameLose: $isGameLose, 
                       difficultyModel: $difficultyModel, 
                       timer: $timer
                )
                Spacer()
                NumsBoard(selectedNum: $selectedNum, numsArray: $arrayOfArrays.1)
                Spacer()
                
            }
            
            if isGameWin {
                GameWinView()
            }
            
            if isGameLose {
                GameLoseView()
            }
        }
    }
}


extension GameView {
    func getAlert() -> Alert {
        return Alert(
            title: Text("alert_title"),
            message: Text("message_title"),
            primaryButton: .destructive(Text("yes"), action: {
                dismiss()
            }),
            secondaryButton: .cancel(Text("no")))
//        return Alert(
//            title: Text("save_game"),
//            primaryButton: .default(Text("yes"), action: {
//                let unsavedArays = UnsavedArrays(array: arrayOfArrays.0, arrayWithSpace: arrayOfArrays.1)
//                if let encodedData = unsavedArays.encode() {
//                    unsavedNumsArrays = encodedData
//                    unsavedTimer = timer
//                    unsavedErrors = errorCount
//                    unsavedLevelName = difficultyModel.name
//                    isStartingGame = true
//                    
//                    print("Saving arrays: \(unsavedArays)")
//                    print("Encoded arrays: \(encodedData)")
//                    
//                    errorCount = 0
//                    timer = 0
//                    
//                    dismiss()
//                    
//                    print("DEINIT unsavedArays \(unsavedArays) \nunsavedTimer \(unsavedTimer) \nunsavedErrors \(unsavedErrors)")
//                } else {
//                    print("Error encoding arrays in GameView")
//                }
//            }),
//            secondaryButton: .destructive(Text("no"), action: {
//                unsavedNumsArrays = nil
//                unsavedTimer = 0
//                unsavedErrors = 0
//                unsavedLevelName = ""
//                isStartingGame = false
//                
//                print("Game state cleared in GameView")
//                
//                errorCount = 0
//                timer = 0
//                
//                dismiss()
//            })
//        )
    }
}


#Preview {
    GameView(difficultyModel: DifficultyModel(name: "TEST", clearSquares: 1, color: .red))
}


