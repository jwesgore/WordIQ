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
    
    func getCurrentGuess() -> GuessWord {
        return guesses[currentPosition]
    }
    
    /// Goto next guess, returns false if board has been maxed out
    func nextGuess() -> Bool {
        self.currentPosition += 1
        if boardSize == currentPosition { return false }
        
        self.guesses[currentPosition].addHints(hints: hints)
        return true
    }
    
    func keyPressed(key: String, entryType: KeyboardEntryType) {
        switch entryType {
        case .letter:
            self.guesses[currentPosition].addLetterWithAnimation(letter: key)
        case .delete:
            self.guesses[currentPosition].removeLetter()
        default:
            return
        }
    }
    
    // MARK: Visual updates
    // Used to add hint values to the current guess
    func loadHints() {
        for i in 0..<wordLength {
            guesses[currentPosition].letters[i].value = hints[i]
        }
    }
    
    // Used to reset the board without clearing the hints
    func emptyBoard(loadHints: Bool = false) {
        self.currentPosition = 0
        self.guesses = (0..<boardSize).map { _ in GuessWord(wordLength: wordLength) }
        if loadHints { guesses[0].addHints(hints: hints) }
    }
    
    // Resets the board with a sweeping upwards animation
    func emptyBoardWithAnimation(loadHints:Bool = false, animationLength: Double = 0.25, speed: Double = 4.0, delay: Double = 0.0, done: @escaping () -> Void) {
        var counter = 0.0
        
        for guess in guesses.reversed() {
            DispatchQueue.main.asyncAfter(deadline: .now() + ((animationLength / 2.5 ) * counter) + delay, execute: {
                guess.reset(animationLength: animationLength, speed: speed)
            })
            counter += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + ((animationLength / 2.5) * (counter + speed)) + delay, execute: {
            self.emptyBoard(loadHints: loadHints)
            done()
        })
    }
    
    // MARK: Observer Functions
    func addObserver(observer: GameViewModelObserver) {
        observers.append(observer)
    }
    
    // Reset all values
    func gameOver() {
        self.emptyBoard()
        self.hints = [String](repeating: "", count: wordLength)
    }
    
    // Change the backgrounds of all words
    func setBackground(guess: Word, letterBackgrounds: [Color]) {
        guesses[currentPosition].setBackgroundsWithAnimation(letterBackgrounds: letterBackgrounds)
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
