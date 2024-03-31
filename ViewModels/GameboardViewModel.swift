//
//  WordleViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class GameboardVM: ObservableObject, WordGameVMObserver {
    @Published var guesses: [GuessWord]
    var currentPosition: Int
    
    var boardSize: Int
    var wordLength: Int
    
    var observers = [GameViewModelObserver]()
    
    init(boardSize: Int, wordLength: Int) {
        self.wordLength = wordLength
        self.boardSize = boardSize
        self.guesses = (0..<boardSize).map { _ in GuessWord(wordLength: wordLength) }
        
        self.currentPosition = 0
    }

    func addObserver(observer: GameViewModelObserver) {
        observers.append(observer)
    }
    
    func getCurrentGuess() -> GuessWord {
        return guesses[currentPosition]
    }
    
    func nextGuess() -> Bool {
        currentPosition += 1
        if currentPosition == boardSize {
            return false
        }
        return true
    }
    
    func keyPressed(key: String, entryType: KeyboardEntryType) {
        switch entryType {
        case KeyboardEntryType.letter:
            guesses[currentPosition].addLetter(letter: key)
        case KeyboardEntryType.delete:
            guesses[currentPosition].removeLetter()
        default:
            return
        }
    }
    
    // WordGameVM Functions
    func gameOver() {
        self.currentPosition = 0
        self.guesses = (0..<boardSize).map { _ in GuessWord(wordLength: wordLength) }
    }
    
    func setBackground(guess: Word, letterComparison: [LetterComparison]) {
        guesses[currentPosition].setBackgrounds(letterComparison: letterComparison)
    }
    
}

protocol GameViewModelObserver {
    func gameEnded()
}
