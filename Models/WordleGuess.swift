//
//  WordleGuess.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

class WordleGuess: Identifiable{
    let id = UUID()
    var letters = [[Letter: Any]]()
    var word: String
    var wordSize: Int
    
    init(word: String = "", wordSize: Int = 5){
        self.word = word
        self.wordSize = wordSize
        for _ in 1...wordSize {
            self.letters.append([Letter.letter: " ", Letter.backgroundColor : Color.white])
        }
    }
    
    func printInfo() {
        print(self.id)
        print(self.letters)
        print(self.word)
    }
    
    func addLetter (letter : String) {
        // return if word is already the max size
        // or if letter is longer than 1 (shouldn't ever happen)
        if word.count >= wordSize || letter.count > 1 {
            return
        }
        letters[word.count][Letter.letter] = letter
        word.append(letter)
        self.printInfo()
    }
    
    func removeLetter () {
        // return if word is empty
        if word.count <= 0 {
            return
        }
        word.removeLast()
        letters[word.count][Letter.letter] = " "
        self.printInfo()
    }
    
    func isValidInput() -> Bool {
        // return False if current guess is too short
        if word.count < wordSize {
            return false
        }
        return true
    }
    
    func updateBackground(letterComparison: [LetterComparison]) {
        
        for i in 0..<letterComparison.count {
            switch letterComparison[i] {
            case LetterComparison.differentPosition:
                letters[i][Letter.backgroundColor] = Color.yellow
            case LetterComparison.samePosition:
                letters[i][Letter.backgroundColor] = Color.green
            default:
                letters[i][Letter.backgroundColor] = Color.white
            }
        }
    }
}

