//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    @Binding var letter: String
    @Binding var backgroundColor: Color
    @Binding var borderColor: Color
    
    let sideLength: CGFloat
    let cornerRadiusSize: CGFloat = 8
    
    var body: some View {
        Text(letter)
            .font(.system(size: sideLength / 2.5))
            .frame(width:sideLength, height: sideLength)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadiusSize)
                    .stroke(borderColor, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSize))
    }
}

struct GameRow: View {
    @ObservedObject var guess: GuessWord
    var body: some View {
        HStack {
            ForEach(0..<guess.wordLength, id: \.self) { index in
                GameSquare(letter: $guess.letters[index], backgroundColor: $guess.backgroundColors[index], borderColor: $guess.borderColor, sideLength: guess.boxSize)
            }
        }
    }
}

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

#Preview{
    GameBoard(gameViewModel: GameboardVM(boardSize: 6, wordLength: 5))
}
