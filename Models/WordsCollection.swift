//
//  WordleWord.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation

class WordsCollection {
    var words = [Word]()
    var selectedWord: Word
    
    init(wordLength: Int) {
        // read words file and load each word into the "words" array as a Word object
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                for word in fileContents.components(separatedBy: "\n") {
                    if word.count != wordLength {
                        continue
                    }
                    words.append(Word(word))
                }
            }
        }
        self.selectedWord = words.randomElement()!
        print(self.selectedWord.word)
        print(self.selectedWord.letters)
    }
    
    // change the selected word for another round
    func updateSelectedWord() {
        self.selectedWord = words.randomElement()!
    }
    
    // check if the guess is the correct length and in the list of valid words
    func isValidWord(_ guess: Word) -> Bool {
        if selectedWord.word.count == guess.word.count &&
            words.contains(guess) {
            return true
        }
        return false
    }
    
    // check if guess is the correct word
    func isCorrectWord(_ guess: Word) -> Bool {
        if selectedWord == guess {
            return true
        }
        return false
    }
    
    // assign colors to all letters
    func isSimilarWord(_ guess: Word) -> [LetterComparison] {
        
        var letterComparision = [LetterComparison](repeating: LetterComparison.wrongLetter, count: selectedWord.word.count)
        var letterCount = selectedWord.getLetterCount()
        
        // loop through and flag all of the correct letters in the correct position
        for i in 0..<selectedWord.word.count {
            let testingChar = selectedWord.letters[i]
            if testingChar != guess.letters[i] {
                continue
            }
            letterComparision[i] = LetterComparison.samePosition
            letterCount[testingChar]! -= 1
        }
        
         //loop through and flag all of the correct letters in a different position (if applicable)
        for i in 0..<selectedWord.word.count {
            let testingChar = guess.letters[i]
            if letterComparision[i] == LetterComparison.samePosition ||
                letterCount[testingChar] == 0 ||
                !selectedWord.word.contains(testingChar) {
                continue
            }
            
            letterComparision[i] = LetterComparison.differentPosition
            letterCount[testingChar]! -= 1
        }
        return letterComparision
    }
}
