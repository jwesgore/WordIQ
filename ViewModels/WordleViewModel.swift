//
//  WordleViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class WordleViewModel : ObservableObject, KeyboardObserver {
    @Published var currentGuess: WordleGuess
    @Published var allGuesses: [WordleGuess]
    var boardSize: Int
    var currentPosition: Int = 0
    
    var keyboardModel: KeyboardModel = KeyboardModel()
    var wordleWords: WordleWords = WordleWords()
    
    init(boardSize: Int) {
        self.boardSize = boardSize
        var buildGuesses = [WordleGuess]()
        while buildGuesses.count < boardSize {
            buildGuesses.append(WordleGuess())
        }
        self.allGuesses = buildGuesses
        self.currentGuess = buildGuesses[0]
    }
    
    func nextGuess(){
        // make sure not to go beyond the boardsize
        if currentPosition + 1 == boardSize{
            return
        }
        self.currentPosition += 1
        self.currentGuess = allGuesses[self.currentPosition]
    }
    
    // Check currentGuess for validity
    func submitGuess(){
        // is current guess long enough to be an input
        if !currentGuess.isValidInput() {
            return
        }
        // is it a valid word
        if !wordleWords.isValidWord(currentGuess.word) {
            print("Not a valid word")
            return
        }
        // is it the correct word
        if wordleWords.isCorrectWord(currentGuess.word) {
            print("Correct Word!")
            return
        }
        // if it is not the correct word, goto next guess
        self.nextGuess()
    }
    
    // What to do when a key is pressed
    func keyPressed(_ pressedKey: String) {
        if keyboardModel.letters.contains(pressedKey) {
            self.currentGuess.addLetter(letter: pressedKey)
            self.allGuesses[currentPosition] = self.currentGuess
            return
        }
        switch pressedKey {
        case "Enter":
            self.allGuesses[currentPosition] = self.currentGuess
            self.submitGuess()
        case "Del":
            self.currentGuess.removeLetter()
            self.allGuesses[currentPosition] = self.currentGuess
        default:
            return
        }
    }
}
