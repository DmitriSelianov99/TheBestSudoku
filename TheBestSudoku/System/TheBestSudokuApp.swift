//
// TheBestSudokuApp.swift
// TheBestSudoku


import SwiftUI

@main
struct TheBestSudokuApp: App {
    @AppStorage("onBoarding") var onBoardingStorage: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if onBoardingStorage {
                OnboardingView()
            } else {
                StartView()
            }
        }
    }
}
