//
// GameWinView.swift
// TheBestSudoku


import SwiftUI

struct GameWinView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            ZStack {
                Color.specialYellow
                
                VStack {
                    Text("congratulations")
                        .foregroundStyle(Color.specialBlue)
                        .font(.headline)
                        .bold()
                    
                    Text("winner")
                        .foregroundStyle(Color.specialBlue)
                        .font(.subheadline)
                        .bold()
                    
                    Button("complete") {
                        dismiss()
                    }
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(8)
                    .background(Color.specialGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .frame(height: UIScreen.main.bounds.height / 8)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 50)
            
        }
    }
}


#Preview {
    GameWinView()
}
