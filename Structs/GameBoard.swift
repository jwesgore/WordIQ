//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    let sideLength: CGFloat = 50
    let cornerRadiusSize: CGFloat = 8
    
    var backgroundColor: Color = Color.white
    var value: String
    
    var body: some View {
        Text(value)
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
    @State var guess: WordleGuess = WordleGuess(word:"B")
    
    var body: some View {
        
        HStack{
            GameSquare(value:"")
            GameSquare(value:"")
            GameSquare(value:"")
            GameSquare(value:"")
            GameSquare(value:"")
        }
    }
}

struct GameBoard: View {
    let rowGuesses: [WordleGuess]
    var body: some View {
        VStack{
            ForEach(rowGuesses){ rowGuess in
                GameRow(guess: rowGuess)
            }
        }
    }
}
