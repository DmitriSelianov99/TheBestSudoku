//
// OnboardingView.swift
// TheBestSudoku


import SwiftUI

struct OnboardingView: View {
    
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FirstPage(selectedTab: $selectedTab)
                .tag(1)
            SecondPage(selectedTab: $selectedTab)
                .tag(2)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnboardingView()
}

struct SecondPage: View {
    @Binding var selectedTab: Int
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.onBoarding2.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 50) {
                Spacer()
                Text("hi")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                VStack {
                    Text("secondOnBoarding1")
                    + Text("secondOnBoarding2").bold()
                    + Text("secondOnBoarding3")
                }
                .foregroundColor(.black)
                .lineSpacing(10.0)
                Spacer()
                NextPageButton(selectedTab: $selectedTab, isPresented: $isPresented)
                    .fullScreenCover(isPresented: $isPresented, content: {
                        StartView()
                    })
            }
            .padding()
            
        }
    }
}

struct FirstPage: View {
    @Binding var selectedTab: Int
    @State var isPresented: Bool = false
    var body: some View {
        ZStack {
            Color.onBoarding1.ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                Text("firstOnBoarding")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                NextPageButton(selectedTab: $selectedTab, isPresented: $isPresented)
            }
        }
    }
}


struct NextPageButton: View {
    @Binding var selectedTab: Int
    @Binding var isPresented: Bool
    @AppStorage("onBoarding") var onBoardingStorage: Bool?
    
    var body: some View {
        Button(action: {
            if selectedTab < 2 {
                withAnimation(.easeIn) {
                    selectedTab += 1
                }
            } else {
                onBoardingStorage = false
                isPresented = true
            }
        }, label: {
            HStack {
                Text(selectedTab == 1 ? "next" : "play")
                    .foregroundColor(.black)
                Image(systemName: "arrow.right")
            }
            .foregroundStyle(Color.black)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        })
    }
}
