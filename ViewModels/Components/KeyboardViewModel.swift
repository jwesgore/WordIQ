import Foundation
import SwiftUI

class KeyboardVM : ObservableObject, WordGameComponentObserver {
    var keyboardModel = KeyboardModel()
    var observers = [KeyboardVMObserver]()
    var pressedKey: String = " "
    var keyboardActive = true
    
    let letterKeyWidthMultiplier = 0.085
    let funcKeyWidthMultiplier = 0.13
    let keyHeightMultiplier = 0.06
    
    @Published var topRow = [BaseComponent]()
    @Published var middleRow = [BaseComponent]()
    @Published var bottomRow = [BaseComponent]()
    
    @Published var keyboardMap: [String: Letter]
 
    init() {
        let height = UIScreen.main.bounds.height * keyHeightMultiplier
        let letterWidth = UIScreen.main.bounds.width * letterKeyWidthMultiplier
        let funtionWidth = UIScreen.main.bounds.width * funcKeyWidthMultiplier
        
        keyboardMap = [String: Letter]()
        
        for letter in keyboardModel.topRowLetters {
            let _letter = Letter(value: letter,
                                 backgroundColor: Color.LetterBackground.standard,
                                 borderColor: BorderColor.inactive,
                                 width: letterWidth,
                                 height: height)
            topRow.append(_letter)
            keyboardMap[letter] = _letter
        }
        
        for letter in keyboardModel.middleRowLetters {
            let _letter = Letter(value: letter,
                                 backgroundColor: Color.LetterBackground.standard,
                                 borderColor: BorderColor.inactive,
                                 width: letterWidth,
                                 height: height)
            middleRow.append(_letter)
            keyboardMap[letter] = _letter
        }
        
        bottomRow.append(Function(value: FunctionImages.enter,
                                backgroundColor: Color.LetterBackground.standard,
                                borderColor: BorderColor.inactive,
                                width: funtionWidth,
                                height: height))
        
        for letter in keyboardModel.bottomRowLetters {
            let _letter = Letter(value: letter,
                                 backgroundColor: Color.LetterBackground.standard,
                                 borderColor: BorderColor.inactive,
                                 width: letterWidth,
                                 height: height)
            bottomRow.append(_letter)
            keyboardMap[letter] = _letter
        }
        
        bottomRow.append(Function(value: FunctionImages.delete,
                                backgroundColor: Color.LetterBackground.standard,
                                borderColor: BorderColor.inactive,
                                width: funtionWidth,
                                height: height))
    }
    
    func keyPressed(key: String) {
        self.pressedKey = key
        if keyboardActive {
            self.notifyObservers()
        }
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
        for letter in keyboardMap {
            letter.value.backgroundColor = Color.LetterBackground.standard
        }
        keyboardActive = true
    }
    
    /// Set backgrounds for all of the keyboard characters
    func setBackground(guess: Word, letterBackgrounds: [Color]) {
        for (letter, color) in zip(guess.letters, letterBackgrounds) {
            let _letter = letter.uppercased()
            if keyboardMap[_letter]?.backgroundColor == Color.LetterBackground.correct ||
                keyboardMap[_letter]?.backgroundColor == Color.LetterBackground.incorrect &&
                color == Color.LetterBackground.incorrect {
                continue
            }
            keyboardMap[_letter]?.backgroundColor = color
        }
    }
}

protocol KeyboardVMObserver {
    func keyPressed(_ key: String)
}
