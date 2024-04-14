import Foundation
import SwiftUI

class WordGameVM: ObservableObject, KeyboardVMObserver {
    
    // constants
    let boardSize: Int
    let wordLength: Int
    
    // Instances of other ViewModels
    var keyboardVM: KeyboardVM
    var gameboardVM: GameboardVM
    var gameOverVM: GameOverVM
    
    var wordsCollection: WordsCollection
    let keyboardModel: KeyboardModel
    
    var componentObservers: [WordGameComponentObserver]
    var subclassObservers: [WordGameSubclassObserver]
    
    init(boardSize: Int, wordLength: Int, wordsFile: String) {
        self.boardSize = boardSize
        self.wordLength = wordLength
        
        self.keyboardModel = KeyboardModel()
        self.keyboardVM = KeyboardVM()
        self.gameOverVM = GameOverVM()
        
        self.gameboardVM = GameboardVM(boardSize: boardSize, wordLength: wordLength)
        self.wordsCollection = WordsCollection(wordLength: wordLength, wordFileName: wordsFile)
        
        self.componentObservers = [WordGameComponentObserver]()
        self.subclassObservers = [WordGameSubclassObserver]()
        
        // add self as an observer
        self.keyboardVM.addObserver(observer: self)
        self.addComponentObserver(observer: keyboardVM)
        self.addComponentObserver(observer: gameboardVM)
    }
    
    func addComponentObserver(observer: WordGameComponentObserver) {
        componentObservers.append(observer)
    }
    
    func addSubclassObserver(observer: WordGameSubclassObserver) {
        subclassObservers.append(observer)
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
    
    // Check currentGuess for validity
    private func notifySubmitGuess() {
        let guess = gameboardVM.getCurrentGuess()
        let guessWord = guess.getWord()
        
        // first validate the word using the WordsCollection
        if wordsCollection.isValidWord(guessWord) {
            // run the comparison and send it off to the keyboard and gameboard
            let letterBackgrounds = wordsCollection.isSimilarWord(guessWord)
            setBackground(guess: guessWord, letterBackgrounds: letterBackgrounds)
            
            for observer in subclassObservers { observer.submitGuess(guessWord) }
        } else {
            guess.invalidWord()
        }
    }
    
    /// Keyboard Observer Function
    ///  Passed the pressed key along to the GameBoardVM if keyboard is in the active state
    func keyPressed(_ key: String) {
        if keyboardModel.letters.contains(key) {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.letter)
        }
        else if key == FunctionImages.delete {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.delete)
        }
        else if key == FunctionImages.enter {
            print(gameboardVM.currentPosition)
            notifySubmitGuess()
        }
    }
    
}

protocol WordGameSubclassObserver {
    func submitGuess(_ guessWord : Word)
}

protocol WordGameComponentObserver {
    func gameOver()
    func setBackground(guess:Word, letterBackgrounds: [Color])
}
