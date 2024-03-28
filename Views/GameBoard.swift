//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    var value: String
    
    let sideLength: CGFloat = 50
    let cornerRadiusSize: CGFloat = 8
    
    var backgroundColor: Color = Color.white
    
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
    var decomposedWord: [String]
    
    var body: some View {
        HStack {
            ForEach(decomposedWord.indices, id: \.self) { index in
                GameSquare(value: decomposedWord[index])
            }
        }
    }
}

struct GameBoard: View {
    @ObservedObject var wordleViewModel: WordleViewModel
    
    var body: some View {
        VStack {
            ForEach(wordleViewModel.allGuesses){ guess in
                GameRow(decomposedWord: guess.decomposedWord)
            }
        }
    }
}



