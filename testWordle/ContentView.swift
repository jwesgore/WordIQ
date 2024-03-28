//
//  ContentView.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI
func makeList(size: Int) -> [WordleGuess]{
    var WordleGuesses = [WordleGuess]()
    while WordleGuesses.count < size {
        WordleGuesses.append(WordleGuess())
    }
    return WordleGuesses
}

struct ContentView: View {
    @State var message: String = ""
    var WordleGuesses = makeList(size: 6)
    
    var body: some View {
        
        VStack {
            GameBoard(rowGuesses: WordleGuesses)
                .padding()
            Keyboard {
                newMessage in self.message = newMessage
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

