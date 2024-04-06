import Foundation
import SwiftUI

class GuessWord: Identifiable, Equatable, ObservableObject {
    
    let id: UUID
    var wordLength: Int
    var word: String
    @Published var letters: [Letter]
    @Published var submitted = false
    
    init(wordLength: Int) {
        let edgeLength = 0.8 * (UIScreen.main.bounds.width / Double(wordLength))
        
        self.id = UUID()
        
        self.wordLength = wordLength
        self.word = ""
        self.letters = (0..<wordLength).map { _ in
            Letter(value: "",
                   backgroundColor: LetterBackgroundColor.standard,
                   borderColor: BorderColor.inactive,
                   width: edgeLength,
                   height: edgeLength)
        }
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
        
        letters[word.count].value = letter
        letters[word.count].borderColor = BorderColor.active
        word.append(letter)
        printInfo()
    }
    
    func removeLetter() {
        if word.count <= 0 {
            return
        }
        word.removeLast()
        letters[word.count].value = " "
        letters[word.count].borderColor = BorderColor.inactive
        printInfo()
    }
    
    func setBackgrounds(letterComparison: [LetterComparison]) {
        for i in 0..<letterComparison.count {
            
            letters[i].borderColor = BorderColor.clear
            if letterComparison[i] == LetterComparison.differentPosition {
                letters[i].backgroundColor = LetterBackgroundColor.contains
            }
            else if letterComparison[i] == LetterComparison.samePosition {
                letters[i].backgroundColor = LetterBackgroundColor.correct
            }
            else {
                letters[i].backgroundColor = LetterBackgroundColor.incorrect
            }
        }
    }
    
    func getWord() -> Word {
        return Word(word)
    }
}
