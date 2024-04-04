//
//  WordGameViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/30/24.
//

import Foundation

class WordGameVM: ObservableObject, KeyboardVMObserver, GameOverVMObserver {
    
    // constants
    let boardSize: Int
    let wordLength: Int
    
    // Instances of other ViewModels
    var keyboardVM: KeyboardVM
    var gameboardVM: GameboardVM
    var gameOverVM: GameOverVM
    
    var wordsCollection: WordsCollection
    let keyboardModel: KeyboardModel
    
    var observers: [WordGameVMObserver]
    
    init(boardSize: Int, wordLength: Int, wordsFile: String) {
        self.boardSize = boardSize
        self.wordLength = wordLength
        
        self.keyboardModel = KeyboardModel()
        self.keyboardVM = KeyboardVM()
        self.gameOverVM = GameOverVM()
        
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
    func setBackground(guess:Word, letterComparison: [LetterComparison]) {
        for observer in observers {
            observer.setBackground(guess:guess, letterComparison: letterComparison)
        }
    }
    
    // WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(){
        
        let guess = gameboardVM.getCurrentGuess()
        let guessWord = guess.getWord()
        
        // first validate the word using the WordsCollection
        if !wordsCollection.isValidWord(guessWord) {
            print("Not a valid word")
            return
        }
        
        // run the comparison and send it off to the keyboard and gameboard
        let letterComparison = wordsCollection.isSimilarWord(guessWord)
        setBackground(guess: guessWord, letterComparison: letterComparison)
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            gameOverVM.open()
            print("Correct Word!")
            return
        }
        
        if !gameboardVM.nextGuess() {
            gameOverVM.open()
            print("Game Over")
            return
        }
    }
    
    // KeyboardVMObserver Functions
    func keyPressed(_ key: String) {
        if keyboardModel.letters.contains(key) {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.letter)
        }
        else if key == FunctionImages().delete {
            gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.delete)
        }
        else if key == FunctionImages().enter {
            submitGuess()
        }
    }
    
    // GameOverVMObserver Function
    func closePressed() {
        
    }
    
    func buttonPressed() {
        gameOver()
        wordsCollection.updateSelectedWord()
    }
}

protocol WordGameVMObserver {
    func gameOver()
    func setBackground(guess:Word, letterComparison: [LetterComparison])
}
