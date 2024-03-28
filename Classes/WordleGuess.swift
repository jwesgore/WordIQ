//
//  WordleGuess.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation

class WordleGuess: Identifiable {
    
    let id = UUID()
    
    var word: String
    var size: Int
    
    init(word: String = "", size: Int = 5){
        self.word = word
        self.size = size
    }
    
    func addLetter (letter : Character) {
        // return if word is already the max size
        if word.count >= size {
            return
        }
        word.append(letter)
        print(word)
    }
    
    func removeLetter () {
        // return if word is empty
        if word.count <= 0 {
            return
        }
        word.removeLast()
        print(word)
    }
    
    func submitGuess() {
        // return if current guess is too short
        if word.count < size {
            print("Guess is too short")
            return
        }
        print("Submitting")
    }
}
