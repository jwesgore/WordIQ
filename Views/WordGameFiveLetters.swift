//
//  ContentView.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI

struct WordGameFiveLetters: View {
    @StateObject var gameViewModel = GameViewModel(boardSize: 6, wordLength: 5)
    @StateObject var keyboardViewModel = KeyboardViewModel()
    @StateObject var gameOverModel = GameOverModel()
    
    var body: some View {
        ZStack{
            VStack {
                GameBoard(gameViewModel: gameViewModel)
                    .padding()
                
                KeyboardView (keyboardViewModel: keyboardViewModel)
            }
            .onAppear() {
                keyboardViewModel.addObserver(observer: gameViewModel)
                gameOverModel.addObserver(observer: gameViewModel)
                gameViewModel.addObserver(observer: gameOverModel)
            }
            if gameOverModel.isActive {
                GameOver(model: gameOverModel)
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    WordGameFiveLetters()
}

