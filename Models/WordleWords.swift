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
    
    func isSimilarWord(_ guess: String) -> [LetterComparison] {
        let guessLowerCase = guess.lowercased()
        var letterComparision = [LetterComparison]()
        
        for (index, char1) in selectedWord.enumerated() {
            let char2 = guessLowerCase[guessLowerCase.index(guessLowerCase.startIndex, offsetBy: index)]
            
            if char1 == char2 {
                letterComparision.append(LetterComparison.samePosition)
            }
            else if selectedWord.contains(char2) {
                letterComparision.append(LetterComparison.differentPosition)
            }
            else {
                letterComparision.append(LetterComparison.wrongLetter)
            }
        }
        return letterComparision
    }
    
    func compare(guess: WordleGuess) {
        
    }
}
