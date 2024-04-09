import Foundation
import SwiftUI

class GuessWord: Identifiable, Equatable, ObservableObject {
    
    @Published var letters: [Letter]
    @Published var submitted = false
    @Published var shake = false
    
    let id: UUID
    var wordLength: Int
    var word: String
    
    init(wordLength: Int) {
        let edgeLength = 0.8 * (ScreenSize().width! / Double(wordLength))
        
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
    
    /// Adds a letter onto the word
    func addLetter(letter: String) {
        /// Returns if the word is too long or if letter is somehow longer than 1 character
        if word.count >= wordLength || letter.count > 1 { return }
        
        letters[word.count].value = letter
        letters[word.count].borderColor = BorderColor.active
        word.append(letter)
    }
    
    /// Deletes the last letter from the word
    func removeLetter() {
        /// Return is word size is 0
        if word.count <= 0 { return }
        
        word.removeLast()
        letters[word.count].value = " "
        letters[word.count].borderColor = BorderColor.inactive
    }
    
    /// Sets the background colors for the row
    func setBackgrounds(letterBackgrounds: [Color]) {
        for i in 0..<letterBackgrounds.count {
            letters[i].borderColor = BorderColor.clear
            letters[i].backgroundColor = letterBackgrounds[i]
        }
    }
    
    /// Shakes the row if word is invalid
    func invalidWord() {
        withAnimation(.easeInOut(duration: 0.3)) {
            shake = true
        }
        shake = false
    }
    
    /// Returns a Word instance of the GuessWord
    func getWord() -> Word {
        return Word(word)
    }
}
