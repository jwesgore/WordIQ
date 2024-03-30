//
//  WordleViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class GameViewModel : ObservableObject, KeyboardObserver {
    @Published var currentGuess: GuessWord
    @Published var allGuesses: [GuessWord]
    var boardSize: Int
    var currentPosition: Int = 0
    
    var keyboardModel: KeyboardModel = KeyboardModel()
    var wordleWords: WordsCollection = WordsCollection(wordLength: 5)
    
    init(boardSize: Int, wordLength: Int) {
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
            return
        }
        self.currentPosition += 1
        self.currentGuess = allGuesses[self.currentPosition]
    }
    
    // Check currentGuess for validity
    func submitGuess(){
        let guessWord = currentGuess.getWord()
        // is current guess long enough to be an input and is it in the list of valid words
        if !wordleWords.isValidWord(guessWord) {
            print("Not a valid word")
            return
        }
        
        let letterComparison = wordleWords.isSimilarWord(guessWord)
        currentGuess.setBackgrounds(letterComparison: letterComparison)
        
        // is it the correct word
        if wordleWords.isCorrectWord(guessWord) {
            print("Correct Word!")
            return
        }
        print(currentGuess.backgroundColors)
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
