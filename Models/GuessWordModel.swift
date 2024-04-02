//
//  WordleGuess.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

class GuessWord: Identifiable, Equatable, ObservableObject {

    let id: UUID
    var wordLength: Int
    var word: String
    var boxSize: CGFloat
    
    @Published var borderColor: Color
    @Published var letters: [String]
    @Published var backgroundColors: [Color]
    
    init(wordLength: Int) {
        self.id = UUID()
        
        self.wordLength = wordLength
        self.word = ""
        self.letters = [String](repeating: " ", count: wordLength)
        self.backgroundColors = [Color](repeating: Color(UIColor.systemBackground), count: wordLength)
        
        self.boxSize = 0.8 * (UIScreen.main.bounds.width / Double(wordLength))
        
        self.borderColor = Color.gray
    }
    
    static func == (lhs: GuessWord, rhs: GuessWord) -> Bool {
        return lhs.word == rhs.word
    }
    
    func printInfo() {
        print(word)
        print(letters)
    }
    
    func addLetter(letter: String) {
        if word.count >= wordLength || letter.count > 1 {
            return
        }
        letters[word.count] = letter
        word.append(letter)
        printInfo()
    }
    
    func removeLetter() {
        if word.count <= 0 {
            return
        }
        word.removeLast()
        letters[word.count] = " "
        printInfo()
    }
    
    func setBackgrounds(letterComparison: [LetterComparison]) {
        for i in 0..<letterComparison.count {
            if letterComparison[i] == LetterComparison.differentPosition {
                backgroundColors[i] = Color.yellow
            }
            else if letterComparison[i] == LetterComparison.samePosition {
                backgroundColors[i] = Color.green
            }
        }
    }
    
    func getWord() -> Word {
        return Word(word)
    }
}
