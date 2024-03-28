//
//  WordleWord.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation

class WordleWords {
    var words = [String]()
    var selectedWord: String
    
    init() {
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                self.words = fileContents.components(separatedBy: "\n")
            }
        }
        self.selectedWord = words.randomElement()!
        print(self.selectedWord)
    }
    
    func updateSelectedWord() {
        self.selectedWord = words.randomElement()!
    }
    
    func isValidWord(_ guess: String) -> Bool {
        if words.contains(where: {$0.caseInsensitiveCompare(guess) == .orderedSame}){
            return true
        }
        return false
    }
    
    func isCorrectWord(_ guess: String) -> Bool {
        if selectedWord.compare(guess, options: [.caseInsensitive]) == .orderedSame {
            return true
        }
        return false
    }
    
    func compare(guess: WordleGuess) {
        
    }
}
