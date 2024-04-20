/// All views in this file are used to make the entire play area
///
/// File contents:
///     - Gameboard
///     - GameRow
///     - Gamequare

import Foundation
import SwiftUI

/// View of the entire gameboard containing multiple guess words
struct GameBoard: View {
    @ObservedObject var gameboardVM: GameboardVM
    
    var body: some View {
        VStack(spacing:4) {
            ForEach(gameboardVM.guesses){ guess in
                GameRow(guess: guess)
            }
        }
    }
}

/// View of each row on the board containing a single guess word
/// This view controls the animation that changes the background of the squares
struct GameRow: View {
    @ObservedObject var guess: GuessWord
    let animationDuration: Double = 0.5
    
    var body: some View {
        HStack (spacing:4)  {
            ForEach(0..<guess.wordLength, id: \.self) { index in
                GameSquare(letter: guess.letters[index])
                    .animation(.easeInOut(duration: animationDuration).delay(Double(index) * 0.125), value:guess.submitted)
            }
        }
        .modifier(ShakeEffect(animatableData: CGFloat(guess.shake ? 1.5 : 0)))
    }
}

/// View of each letter of a guess word
/// This view controls the animation of all the letters fading in and out
struct GameSquare: View {
    @ObservedObject var letter: Letter
    
    var body: some View {
        Text(letter.value)
            .font(.system(size: letter.width / 2.5))
            .foregroundStyle(.opacity(letter.opacity))
            .animation(letter.value == "" ? nil : .easeInOut(duration: 0.2), value: letter.value)
            .frame(width:letter.width, height: letter.height)
            .background(letter.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: letter.cornerRadius)
                    .stroke(letter.borderColor, lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: letter.cornerRadius))
    }
}

#Preview{
    GameBoard(gameboardVM: GameboardVM(boardSize: 6, wordLength: 5))
}
