//
//  WordleViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class GameViewModel : ObservableObject, KeyboardObserver, GameOverObserver {
    @Published var currentGuess: GuessWord
    @Published var allGuesses: [GuessWord]
    
    var boardSize: Int
    var currentPosition: Int
    var wordLength: Int
    
    var keyboardModel: KeyboardModel = KeyboardModel()
    var wordsCollection: WordsCollection = WordsCollection(wordLength: 5)
    var observers = [GameViewModelObserver]()
    
    init(boardSize: Int, wordLength: Int) {
        self.wordLength = wordLength
        self.currentPosition = 0
        
        self.boardSize = boardSize
        var buildGuesses = [GuessWord]()
        while buildGuesses.count < boardSize {
            buildGuesses.append(GuessWord(wordLength: wordLength))
        }
        self.allGuesses = buildGuesses
        self.currentGuess = buildGuesses[0]
    }
    
    func nextGuess(){
        // make sure not to go beyond the boardsize
        if currentPosition + 1 == boardSize{
            for observer in observers {
                observer.gameEnded()
            }
            wordsCollection.updateSelectedWord()
            return
        }
        self.currentPosition += 1
        self.currentGuess = allGuesses[self.currentPosition]
    }
    
    // Check currentGuess for validity
    func submitGuess(){
        let guessWord = currentGuess.getWord()
        // is current guess long enough to be an input and is it in the list of valid words
        if !wordsCollection.isValidWord(guessWord) {
            print("Not a valid word")
            return
        }
        
        let letterComparison = wordsCollection.isSimilarWord(guessWord)
        currentGuess.setBackgrounds(letterComparison: letterComparison)
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            print("Correct Word!")
            for observer in observers {
                observer.gameEnded()
            }
            wordsCollection.updateSelectedWord()
            return
        }
        print(currentGuess.backgroundColors)
        // if it is not the correct word, goto next guess
        self.nextGuess()
    }
    
    func addObserver(observer: GameViewModelObserver) {
        observers.append(observer)
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
    
    func resetBoard() {
        currentPosition = 0
        var buildGuesses = [GuessWord]()
        while buildGuesses.count < boardSize {
            buildGuesses.append(GuessWord(wordLength: self.wordLength))
        }
        self.allGuesses = buildGuesses
        self.currentGuess = buildGuesses[0]
    }
    
    func closePressed() {
        
    }
    
    func buttonPressed() {
        resetBoard()
    }
}

protocol GameViewModelObserver {
    func gameEnded()
}
