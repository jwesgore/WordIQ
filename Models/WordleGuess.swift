//
//  WordleGuess.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation

class WordleGuess: Identifiable{
    let id = UUID()
    var decomposedWord: [String]
    var word: String
    var wordSize: Int
    
    init(word: String = "", wordSize: Int = 5){
        
        self.word = word
        self.wordSize = wordSize
        self.decomposedWord = [String](repeating: " ", count: wordSize)
        
        print(self.id)
    }
    
    func printInfo() {
        print(self.id)
        print(self.decomposedWord)
        print(self.word)
    }
    
    func addLetter (letter : String) {
        // return if word is already the max size
        // or if letter is longer than 1 (shouldn't ever happen)
        if word.count >= wordSize || letter.count > 1 {
            return
        }
        decomposedWord[word.count] = letter
        word.append(letter)
        self.printInfo()
    }
    
    func removeLetter () {
        // return if word is empty
        if word.count <= 0 {
            return
        }
        word.removeLast()
        decomposedWord[word.count] = " "
        self.printInfo()
    }
    
    func isValidInput() -> Bool {
        // return False if current guess is too short
        if word.count < wordSize {
            return false
        }
        return true
    }
}

