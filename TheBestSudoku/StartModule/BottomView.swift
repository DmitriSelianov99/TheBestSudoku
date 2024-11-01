//
// BottomView.swift
// TheBestSudoku


import SwiftUI

struct BottomView: View {
    
    @State var isPresentedStatistics: Bool = false
    @State var isPresentedDonationView: Bool = false
    
    var currentLanguage: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }
    
    var body: some View {
        HStack {
            Button(action: {
                isPresentedStatistics.toggle()
            }, label: {
                Text("statistics")
                    .foregroundStyle(Color.specialBlue)
                    .bold()
                Image(systemName: "chart.bar.xaxis.ascending")
                    .foregroundStyle(Color.specialBlue)
            })
            .foregroundStyle(Color.black)
            .sheet(isPresented: $isPresentedStatistics, content: {
                StatisticsView()
                    .presentationDragIndicator(.visible)
            })
            Spacer()
            
            if currentLanguage == "ru" {
                Button {
                    isPresentedDonationView = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(Color.specialBlue)
                }
            }

        }
        .sheet(isPresented: $isPresentedDonationView, content: {
            DonationView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .padding(.horizontal, 20)
    }
}

#Preview {
    BottomView()
}
