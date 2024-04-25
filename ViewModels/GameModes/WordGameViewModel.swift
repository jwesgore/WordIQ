import Foundation
import SwiftUI

class WordGameVM: ObservableObject, KeyboardVMObserver{
    
    // constants
    let boardSize: Int
    let wordLength: Int
    
    // Instances of other ViewModels
    var keyboardVM: KeyboardVM
    var gameboardVM: GameboardVM
    var gameOverVM: GameOverVM
    var timerVM: TimerVM
    
    var wordsCollection: WordsCollection
    let keyboardModel: KeyboardModel
    
    var componentObservers: [WordGameComponentObserver]
    var subclassObservers: [WordGameSubclassObserver]
    
    init(options: GameModeOptions) {
        self.boardSize = options.boardSize
        self.wordLength = options.wordLength
        
        self.keyboardModel = KeyboardModel()
        self.keyboardVM = KeyboardVM()
        self.gameOverVM = GameOverVM()
        self.timerVM = TimerVM()
        
        self.gameboardVM = GameboardVM(boardSize: boardSize, wordLength: wordLength)
        self.wordsCollection = WordsCollection(wordLength: wordLength, wordList: options.wordList)
        
        self.componentObservers = [WordGameComponentObserver]()
        self.subclassObservers = [WordGameSubclassObserver]()
        
        // add self as an observer
        self.keyboardVM.addObserver(observer: self)
        self.addComponentObserver(observer: keyboardVM)
        self.addComponentObserver(observer: gameboardVM)
    }
    
    // Check currentGuess for validity
    private func isValidWord() {
        let guess = gameboardVM.getCurrentGuess()
        let guessWord = guess.getWord()
        var valid = false
        
        // first validate the word using the WordsCollection
        if wordsCollection.isValidWord(guessWord) {
            // run the comparison and send it off to the keyboard and gameboard
            let letterBackgrounds = wordsCollection.isSimilarWord(guessWord)
            self.setBackground(guess: guessWord, letterBackgrounds: letterBackgrounds)
            valid = true
        } else {
            guess.invalidWord()
        }
        
        self.notifySubmitGuess(guess: guessWord, valid: valid)
    }
    
    // MARK: Keyboard Observer Function
    // Passed the pressed key along to the GameBoardVM if keyboard is in the active state
    func keyPressed(_ key: String) {
        if !timerVM.active {timerVM.startTimer()}
        switch key {
        case FunctionImages.enter:
            isValidWord()
        case FunctionImages.delete:
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.delete)
        default:
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.letter)
        }
    }
    
    // MARK: Subclass Observer Functions
    func addSubclassObserver(observer: WordGameSubclassObserver) {
        subclassObservers.append(observer)
    }
    
    func notifySubmitGuess(guess: Word, valid: Bool) {
        for observer in subclassObservers {
            observer.submitGuess(guessWord: guess, valid: valid)
        }
    }
    
    // MARK: Component Observer Functions
    func addComponentObserver(observer: WordGameComponentObserver) {
        componentObservers.append(observer)
    }
    
    // notify the keyboard and gameboard that the game has ended and they need to reset their values
    func gameOver() {
        for observer in componentObservers {
            observer.gameOver()
        }
    }
    
    // notify the keyboard and the gameboard that they need to update their components backgrounds
    func setBackground(guess:Word, letterBackgrounds: [Color]) {
        for observer in componentObservers {
            observer.setBackground(guess:guess, letterBackgrounds: letterBackgrounds)
        }
    }
}

protocol WordGameSubclassObserver {
    func submitGuess(guessWord : Word, valid: Bool)
}

protocol WordGameComponentObserver {
    func gameOver()
    func setBackground(guess:Word, letterBackgrounds: [Color])
}
