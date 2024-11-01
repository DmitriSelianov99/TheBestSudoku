//
// View + Extensions.swift
// TheBestSudoku


import SwiftUI

extension View {
    func hidden(_ shouldHide: Int) -> some View {
        opacity(shouldHide == 0 ? 0 : 1)
    }
}
