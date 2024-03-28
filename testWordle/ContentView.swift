//
//  ContentView.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var wordleViewModel = WordleViewModel(boardSize: 6)
    @StateObject var keyboardViewModel = KeyboardViewModel()
    
    var body: some View {
        VStack {
            GameBoard(wordleViewModel: wordleViewModel)
                .padding()
            
            KeyboardView (keyboardViewModel: keyboardViewModel)
        }
        .onAppear() {
            keyboardViewModel.addObserver(observer: wordleViewModel)
        }
    }
}

#Preview {
    ContentView()
}

