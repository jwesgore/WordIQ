//
//  ContentView.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI

struct WordGameFiveLetters: View {
    let boardSize: Int
    let wordLength: Int
    let wordsFile: String
   
    var body: some View {
        let wordGameVM = WordGameVM(boardSize: self.boardSize, wordLength: self.wordLength, wordsFile: self.wordsFile)
        
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
    WordGameFiveLetters(boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
}

