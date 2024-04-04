//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameBoard: View {
    @ObservedObject var gameViewModel: GameboardVM
    
    var body: some View {
        VStack {
            ForEach(gameViewModel.guesses){ guess in
                GameRow(guess: guess)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct GameRow: View {
    @ObservedObject var guess: GuessWord
    let animationDuration: Double = 0.5
    
    var body: some View {
        HStack {
            ForEach(0..<guess.wordLength, id: \.self) { index in
                GameSquare(letter: guess.letters[index])
                    .animation(.easeInOut(duration: animationDuration).delay(Double(index) * 0.1), value:guess.submitted)
            }
        }
    }
}

struct GameSquare: View {
    @ObservedObject var letter: Letter
    
    let cornerRadiusSize: CGFloat = 8
    
    var body: some View {
        Text(letter.value)
            .font(.system(size: letter.width / 2.5))
            .animation(letter.value == " " ? nil : .easeInOut, value: letter.value)
            .frame(width:letter.width, height: letter.height)
            .background(letter.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadiusSize)
                    .stroke(letter.borderColor, lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSize))
    }
}

#Preview{
    GameBoard(gameViewModel: GameboardVM(boardSize: 6, wordLength: 5))
}
