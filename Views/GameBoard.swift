//
//  GameRow.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct GameSquare: View {
    var letter: [Letter: Any]
    
    let sideLength: CGFloat = 50
    let cornerRadiusSize: CGFloat = 8
    
    var body: some View {
        let content = letter[Letter.letter] as? String ?? ""
        let backgroundColor = letter[Letter.backgroundColor] as? Color ?? Color.white
        
        Text(content)
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
    var letters: [[Letter: Any]]
    
    var body: some View {
        HStack {
            ForEach(letters.indices, id: \.self) { index in
                GameSquare(letter: letters[index])
            }
        }
    }
}

struct GameBoard: View {
    @ObservedObject var wordleViewModel: WordleViewModel
    
    var body: some View {
        VStack {
            ForEach(wordleViewModel.allGuesses){ guess in
                GameRow(letters: guess.letters)
            }
        }
    }
}



