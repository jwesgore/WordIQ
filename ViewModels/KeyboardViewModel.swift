import Foundation
import SwiftUI

class KeyboardVM : ObservableObject, WordGameVMObserver {
    var keyboardModel = KeyboardModel()
    var observers = [KeyboardVMObserver]()
    var pressedKey: String = " "
    
    let letterKeyWidthMultiplier = 0.085
    let funcKeyWidthMultiplier = 0.13
    let keyHeightMultiplier = 0.06
    
    @Published var topRow = [BaseComponent]()
    @Published var middleRow = [BaseComponent]()
    @Published var bottomRow = [BaseComponent]()
 
    init() {
        let height = UIScreen.main.bounds.height * keyHeightMultiplier
        let letterWidth = UIScreen.main.bounds.width * letterKeyWidthMultiplier
        let funtionWidth = UIScreen.main.bounds.width * funcKeyWidthMultiplier
        
        for letter in keyboardModel.topRowLetters {
            topRow.append(Letter(value: letter,
                                 backgroundColor: LetterBackgroundColor().standard,
                                 borderColor: BorderColor().inactive,
                                 width: letterWidth,
                                 height: height))
        }
        
        for letter in keyboardModel.middleRowLetters {
            middleRow.append(Letter(value: letter,
                                 backgroundColor: LetterBackgroundColor().standard,
                                 borderColor: BorderColor().inactive,
                                 width: letterWidth,
                                 height: height))
        }
        
        bottomRow.append(Function(value: FunctionImages().enter,
                                backgroundColor: LetterBackgroundColor().standard,
                                borderColor: BorderColor().inactive,
                                width: funtionWidth,
                                height: height))
        
        for letter in keyboardModel.bottomRowLetters {
            bottomRow.append(Letter(value: letter,
                                 backgroundColor: LetterBackgroundColor().standard,
                                 borderColor: BorderColor().inactive,
                                 width: letterWidth,
                                 height: height))
        }
        
        bottomRow.append(Function(value: FunctionImages().delete,
                                backgroundColor: LetterBackgroundColor().standard,
                                borderColor: BorderColor().inactive,
                                width: funtionWidth,
                                height: height))
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
            for letter in row {letter.backgroundColor = LetterBackgroundColor().standard}
        }
    }
    
    func setBackground(guess: Word, letterComparison: [LetterComparison]) {
        var map = [String: Color]()
        
        // build map which has a key of the letter and a value of color based on the highest ranking of LetterComparison so far
        for (letter, comparison) in zip(guess.letters, letterComparison) {
            if map[letter] == nil {
                switch comparison {
                case LetterComparison.samePosition:
                    map[letter] = LetterBackgroundColor().correct
                case LetterComparison.differentPosition:
                    map[letter] = LetterBackgroundColor().contains
                case LetterComparison.wrongLetter:
                    map[letter] = LetterBackgroundColor().incorrect
                }
            } 
            else {
                if map[letter] == LetterBackgroundColor().contains && comparison == LetterComparison.samePosition {
                    map[letter] = LetterBackgroundColor().correct
                }
            }
        }
        
        // itterate through all of the keys and assign a background color if appropriate
        for row in [topRow, middleRow, bottomRow] {
            for letter in row {
                // If key is already green, grayed out, or not even in the guess, just skip it
                if letter.backgroundColor == LetterBackgroundColor().correct ||
                    letter.backgroundColor == LetterBackgroundColor().incorrect ||
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
