//
// DonationView.swift
// TheBestSudoku


import SwiftUI

struct DonationView: View {
    var body: some View {
        ZStack {
            Color.onBoarding2.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("На данный момент монетизация приложения недоступна.")
                Text("Но вы можете помочь проекту донатом 🥹")
                HStack {
                    Text("Тинькофф:")
                    Text("5536 9141 4907 1213").bold().textSelection(.enabled)
                }
                Text("*просто зажмите номер карты для копирования")
                    .font(.caption)
            }
            .foregroundColor(.black)
            .font(.title2)
            .padding()
        }
    }
}

#Preview {
    DonationView()
}
