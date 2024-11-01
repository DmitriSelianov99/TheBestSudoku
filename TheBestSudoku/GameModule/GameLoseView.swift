//
// GameLoseView.swift
// TheBestSudoku


import SwiftUI

struct GameLoseView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            ZStack {
                Color.specialYellow
                VStack {
                    Text("lose")
                        .foregroundStyle(.red)
                        .font(.headline)
                        .bold()
                    
                    Text("mistakes")
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .bold()
                    
                    HStack {
                        Button("new_game") {
                            dismiss()
                        }
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(8)
                        .background(Color.specialRed)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height / 8)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 50)
        }
    }
}


//#Preview {
//    GameLoseView()
//}
