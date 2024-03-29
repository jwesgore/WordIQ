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
        var guessLetters = [Character]()
        var letterComparision = [LetterComparison]()
        
        // initial pass
        for (index, char1) in selectedWord.enumerated() {
            let char2 = guessLowerCase[guessLowerCase.index(guessLowerCase.startIndex, offsetBy: index)]
            guessLetters.append(char2)
            
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
        
        // cleanup
        // some words may still show that a letter is misplaced if the correct letter has already been identified
        for (index, value) in letterComparision.enumerated() {
            // skip if letter is wrong letter (doesn't matter anyway)
            if value == LetterComparison.wrongLetter {
                continue
            }
            
            // how many times does this letter show up in the selectedWord
            var numberOfOccurances = selectedWord.filter { $0 == guessLetters[index] }.count
            var numberOfFlagsCorrect = 0
            var numberOfFlagsDifferent = 0
            
            for i in index..<selectedWord.count {
                
                if guessLetters[index] != guessLetters[i] {
                    continue
                }
                if letterComparision[i] == LetterComparison.differentPosition{
                    numberOfFlagsDifferent += 1
                }
                else {
                    numberOfFlagsCorrect += 1
                }
            }
            
            if numberOfOccurances >= (numberOfFlagsDifferent + numberOfFlagsCorrect) {
                continue
            }
            
            for (i, v) in selectedWord.reversed().enumerated() {
                let adjustedIndex = selectedWord.count - 1 - i
                if guessLetters[index] != guessLetters[adjustedIndex] {
                    continue
                }
                if letterComparision[adjustedIndex] == LetterComparison.samePosition {
                    continue
                }
                
                letterComparision[adjustedIndex] = LetterComparison.wrongLetter
                numberOfFlagsDifferent -= 1
                
                if numberOfOccurances >= (numberOfFlagsDifferent + numberOfFlagsCorrect) {
                    break
                }
            }
        }
        
        return letterComparision
    }
    
    func compare(guess: WordleGuess) {
        
    }
}
