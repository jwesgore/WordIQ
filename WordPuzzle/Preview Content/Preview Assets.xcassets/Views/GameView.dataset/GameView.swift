//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    var letter: String
    var backgroundColor: Color
    
    let sideLength: CGFloat = 50
    let cornerRadiusSize: CGFloat = 8
    
    var body: some View {
        Text(letter)
            .frame(width:sideLength, height: sideLength)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadiusSize)
                    .stroke(Color.black, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSize))
    }
}

struct GameRow: View {
    @Binding var guess: GuessWord
    var body: some View {
        let wordLength = guess.wordLength
        HStack {
            ForEach(0..<wordLength, id: \.self) { index in
                GameSquare(letter: guess.letters[index], backgroundColor: guess.backgroundColors[index])
            }
        }
    }
}

struct GameBoard: View {
    @ObservedObject var wordleViewModel: GameViewModel
    
    var body: some View {
        VStack {
            ForEach($wordleViewModel.allGuesses){ guess in
                GameRow(guess: guess)
            }
        }
    }
}
