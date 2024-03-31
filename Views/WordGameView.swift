//
//  ContentView.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI

struct WordGameFiveLetters: View {
    @StateObject var wordGameVM = WordGameVM(boardSize: 6, wordLength: 5)
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                GameBoard(gameViewModel: wordGameVM.gameboardVM)
                Spacer()
                KeyboardView (keyboardViewModel: wordGameVM.keyboardVM)
                    .padding()
            }
            GameOver(model: wordGameVM.gameOverVM)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    WordGameFiveLetters()
}

