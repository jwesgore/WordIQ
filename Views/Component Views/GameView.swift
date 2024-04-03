//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    @ObservedObject var letter: Letter
    
    let cornerRadiusSize: CGFloat = 8
    
    var body: some View {
        Text(letter.value)
            .font(.system(size: letter.width / 2.5))
            .frame(width:letter.width, height: letter.height)
            .background(letter.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadiusSize)
                    .stroke(letter.borderColor, lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSize))
            .rotation3DEffect( Angle(degrees: letter.degrees), axis: (x: 0, y:1, z:0)
            )
            .animation(.easeInOut(duration: 1.0), value: letter.degrees == 0.0)
    }
}

struct GameRow: View {
    @ObservedObject var guess: GuessWord
    var body: some View {
        HStack {
            ForEach(0..<guess.wordLength, id: \.self) { index in
                GameSquare(letter: guess.letters[index])
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
