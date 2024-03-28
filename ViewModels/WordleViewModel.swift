//
//  WordleViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class WordleViewModel : ObservableObject, KeyboardObserver {
    @Published var currentGuess: WordleGuess
    var allGuesses: [WordleGuess] = []
    var boardSize: Int
    var currentPosition: Int = 0
    
    var keyboardModel: KeyboardModel = KeyboardModel()
    
    init(boardSize: Int) {
        self.boardSize = boardSize
        while allGuesses.count < boardSize {
            allGuesses.append(WordleGuess())
        }
        self.currentGuess = self.allGuesses[self.currentPosition]
    }
    
    func keyPressed(_ pressedKey: String) {
        if keyboardModel.letters.contains(pressedKey) {
            self.currentGuess.addLetter(letter: pressedKey)
            return
        }
        switch pressedKey {
        case "Enter":
            self.currentGuess.submitGuess()
        case "Del":
            self.currentGuess.removeLetter()
        default:
            return
        }
    }
}
