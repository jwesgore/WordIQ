import Foundation
import SwiftUI

class WordGameVM: ObservableObject, KeyboardVMObserver, GameOverVMObserver {
    
    // constants
    let boardSize: Int
    let wordLength: Int
    
    // Instances of other ViewModels
    var keyboardVM: KeyboardVM
    var gameboardVM: GameboardVM
    var gameOverVM: GameOverVM
    
    @Published var activeView: ActiveView
    var keyboardActive = true
    
    var wordsCollection: WordsCollection
    let keyboardModel: KeyboardModel
    
    var observers: [WordGameVMObserver]
    
    init(boardSize: Int, wordLength: Int, wordsFile: String) {
        self.boardSize = boardSize
        self.wordLength = wordLength
        
        self.keyboardModel = KeyboardModel()
        self.keyboardVM = KeyboardVM()
        self.gameOverVM = GameOverVM()
        
        self.activeView = ActiveView.wordgame
        
        self.gameboardVM = GameboardVM(boardSize: boardSize, wordLength: wordLength)
        self.wordsCollection = WordsCollection(wordLength: wordLength, wordFileName: wordsFile)
        
        self.observers = [WordGameVMObserver]()
        
        // add self as an observer
        self.keyboardVM.addObserver(observer: self)
        self.gameOverVM.addObserver(observer: self)
        self.addObserver(observer: keyboardVM)
        self.addObserver(observer: gameboardVM)
    }
    
    func addObserver(observer: WordGameVMObserver) {
        observers.append(observer)
    }
    
    // notify the keyboard and gameboard that the game has ended and they need to reset their values
    func gameOver() {
        for observer in observers {
            observer.gameOver()
        }
    }
    
    // notify the keyboard and the gameboard that they need to update their components backgrounds
    func setBackground(guess:Word, letterBackgrounds: [Color]) {
        for observer in observers {
            observer.setBackground(guess:guess, letterBackgrounds: letterBackgrounds)
        }
    }
    
    // WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess() -> String {
        
        let guess = gameboardVM.getCurrentGuess()
        let guessWord = guess.getWord()
        
        // first validate the word using the WordsCollection
        if !wordsCollection.isValidWord(guessWord) {
            guess.invalidWord()
            return "Not a valid word"
        }
        
        // run the comparison and send it off to the keyboard and gameboard
        let letterBackgrounds = wordsCollection.isSimilarWord(guessWord)
        setBackground(guess: guessWord, letterBackgrounds: letterBackgrounds)
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardActive = false
            activeView = ActiveView.gameover
            return "Correct Word!"
        }
        
        if !gameboardVM.nextGuess() {
            keyboardActive = false
            activeView = ActiveView.gameover
            return "Game Over"
        }
        
        return "Next Guess"
    }
    
    /// Keyboard Observer Function
    ///  Passed the pressed key along to the GameBoardVM if keyboard is in the active state
    func keyPressed(_ key: String) {
        if !keyboardActive {
            return
        }
        if keyboardModel.letters.contains(key) {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.letter)
        }
        else if key == FunctionImages.delete {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.delete)
        }
        else if key == FunctionImages.enter {
            print(submitGuess())
        }
    }
    
    /// GameOver Observer Function
    /// Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = ActiveView.wordgame
        gameOver()
        wordsCollection.updateSelectedWord()
        keyboardActive = true
    }
    
    /// GameOver Observer Function
    func mainMenu() {
        activeView = ActiveView.tabview
    }
}

protocol WordGameVMObserver {
    func gameOver()
    func setBackground(guess:Word, letterBackgrounds: [Color])
}
