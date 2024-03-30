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
        @State var gameOver: Bool = gameOverModel.isActive
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
            if gameOver {
                GameOver(model: gameOverModel)
            }
        }
    }
}

#Preview {
    WordGameFiveLetters()
}

