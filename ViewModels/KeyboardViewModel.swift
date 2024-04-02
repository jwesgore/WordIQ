//
//  KeyboardViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation
import SwiftUI

class KeyboardVM : ObservableObject, WordGameVMObserver {
    var keyboardModel = KeyboardModel()
    var observers = [KeyboardVMObserver]()
    var pressedKey: String = " "
    
    let letterKeyWidthMultiplier = 0.085
    let funcKeyWidthMultiplier = 0.13
    let keyHeightMultiplier = 0.06
    
    @Published var topRow = [KeyboardKey]()
    @Published var middleRow = [KeyboardKey]()
    @Published var bottomRow = [KeyboardKey]()
 
    init() {
        for letter in keyboardModel.topRowLetters {
            topRow.append(KeyboardKey(Text(letter), value: letter))
        }
        for letter in keyboardModel.middleRowLetters {
            middleRow.append(KeyboardKey(Text(letter), value: letter))
        }
        // bottom row
        bottomRow.append(KeyboardKey(Image(systemName: "arrow.turn.down.right"), value: "Enter", frameHeightMultiplier: keyHeightMultiplier, frameWidthMultiplier: funcKeyWidthMultiplier))
        for letter in keyboardModel.bottomRowLetters {
            bottomRow.append(KeyboardKey(Text(letter), value: letter, frameHeightMultiplier: keyHeightMultiplier, frameWidthMultiplier: letterKeyWidthMultiplier))
        }
        bottomRow.append(KeyboardKey(Image(systemName: "arrow.backward"), value: "Delete", frameHeightMultiplier: keyHeightMultiplier, frameWidthMultiplier: funcKeyWidthMultiplier))
    }
    
    func keyPressed(key: String) {
        self.pressedKey = key
        self.notifyObservers()
    }
    
    func addObserver(observer: KeyboardVMObserver) {
        observers.append(observer)
    }
    
    func notifyObservers() {
        for observer in self.observers{
            observer.keyPressed(self.pressedKey)
        }
    }
    
    // WordGameVM functions
    func gameOver() {
        for row in [topRow, middleRow, bottomRow] {
            for letter in row {letter.backgroundColor = Color(UIColor.systemBackground)}
        }
    }
    
    func setBackground(guess: Word, letterComparison: [LetterComparison]) {
        var map = [String: Color]()
        
        // build map which has a key of the letter and a value of color based on the highest ranking of LetterComparison so far
        for (letter, comparison) in zip(guess.letters, letterComparison) {
            if map[letter] == nil {
                switch comparison {
                case LetterComparison.samePosition:
                    map[letter] = Color.green
                case LetterComparison.differentPosition:
                    map[letter] = Color.yellow
                case LetterComparison.wrongLetter:
                    map[letter] = Color(UIColor.lightGray)
                }
            } 
            else {
                if map[letter] == Color.yellow && comparison == LetterComparison.samePosition {
                    map[letter] = Color.green
                }
            }
        }
        
        // itterate through all of the keys and assign a background color if appropriate
        for row in [topRow, middleRow, bottomRow] {
            for letter in row {
                // If key is already green, grayed out, or not even in the guess, just skip it
                if letter.backgroundColor == Color.green ||
                    letter.backgroundColor == Color(UIColor.lightGray) ||
                    !guess.letters.contains(letter.value.lowercased()) {
                    continue
                }
                letter.backgroundColor = map[letter.value.lowercased()]!
            }
        }
    }
}

protocol KeyboardVMObserver {
    func keyPressed(_ key: String)
}
