//
// ErrorsView.swift
// TheBestSudoku


import SwiftUI

struct ErrorsView: View {
    
    @Binding var error: Int
    
    var body: some View {
        Text(String(format: NSLocalizedString("errors", comment: "Error message with count"), "\(error)"))
            .foregroundStyle(.specialBlue)
    }
}

#Preview {
    ErrorsView(error: .constant(1))
}

