import Foundation
import SwiftUI

class GameboardVM: ObservableObject, WordGameComponentObserver {
    @Published var guesses: [GuessWord]
    var hints: [String]
    var currentPosition: Int
    
    var boardSize: Int
    var wordLength: Int
    
    var observers = [GameViewModelObserver]()
    
    init(boardSize: Int, wordLength: Int) {
        self.wordLength = wordLength
        self.boardSize = boardSize
        self.guesses = (0..<boardSize).map { _ in GuessWord(wordLength: wordLength) }
        self.hints = [String](repeating: "", count: wordLength)
        
        self.currentPosition = 0
    }
    
    func addObserver(observer: GameViewModelObserver) {
        observers.append(observer)
    }
    
    func getCurrentGuess() -> GuessWord {
        return guesses[currentPosition]
    }
    
    /// Goto next guess, returns false if board has been maxed out
    func nextGuess() -> Bool {
        currentPosition += 1
        if currentPosition == boardSize { return false }
        guesses[currentPosition].addHints(hints: hints)
        return true
    }
    
    func keyPressed(key: String, entryType: KeyboardEntryType) {
        switch entryType {
        case .letter:
            guesses[currentPosition].addLetter(letter: key)
        case .delete:
            guesses[currentPosition].removeLetter()
        default:
            return
        }
    }
    
    func loadHints() {
        for i in 0..<wordLength {
            guesses[currentPosition].letters[i].value = hints[i]
        }
    }
    
    /// Used to reset the board without clearing the hints
    func emptyBoard(loadHints: Bool = false) {
        self.currentPosition = 0
        self.guesses = (0..<boardSize).map { _ in GuessWord(wordLength: wordLength) }
        if loadHints { guesses[0].addHints(hints: hints) }
    }
    
    /// GameboardVM Functions
    /// Reset all values
    func gameOver() {
        self.emptyBoard()
        self.hints = [String](repeating: "", count: wordLength)
    }
    
    /// Change the backgrounds of all words
    func setBackground(guess: Word, letterBackgrounds: [Color]) {
        guesses[currentPosition].setBackgrounds(letterBackgrounds: letterBackgrounds)
        guesses[currentPosition].submitted = true
        
        for i in 0..<wordLength {
            if letterBackgrounds[i] == Color.LetterBackground.correct {
                hints[i] = guess.letters[i].uppercased()
            }
        }
    }
}

protocol GameViewModelObserver {
    func gameEnded()
}
