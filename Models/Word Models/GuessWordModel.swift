import Foundation
import SwiftUI

class GuessWord: Identifiable, Equatable, ObservableObject {
    
    @Published var letters: [Letter]
    @Published var submitted = false
    @Published var shake = false
    var hints: [String]
    
    let id: UUID
    var wordLength: Int
    var word: String
    
    init(wordLength: Int) {
        let edgeLength = 0.8 * (ScreenSize.width! / Double(wordLength))
        
        self.id = UUID()
        
        self.wordLength = wordLength
        self.word = ""
        self.hints = [String](repeating: "", count: wordLength)
        self.letters = (0..<wordLength).map { _ in
            Letter(value: "",
                   backgroundColor: Color.LetterBackground.standard,
                   borderColor: BorderColor.inactive,
                   width: edgeLength,
                   height: edgeLength)
        }
    }
    
    static func == (lhs: GuessWord, rhs: GuessWord) -> Bool {
        return lhs.word == rhs.word
    }
    
    /// Returns a Word instance of the GuessWord
    func getWord() -> Word {
        return Word(word)
    }
    
    func printInfo() {
        print(word)
        print(letters)
    }
    
    // MARK: Modify word value
    /// Adds a letter onto the word
    func addLetter(letter: String) {
        // Returns if the word is too long or if letter is somehow longer than 1 character
        if word.count >= wordLength || letter.count > 1 { return }
        
        letters[word.count].value = letter
        letters[word.count].borderColor = BorderColor.active
        letters[word.count].opacity = 100.0
        word.append(letter)
    }
    
    /// Deletes the last letter from the word
    func removeLetter() {
        // Return is word size is 0
        if word.count <= 0 { return }
        
        word.removeLast()
        letters[word.count].value = hints[word.count]
        letters[word.count].borderColor = BorderColor.inactive
        letters[word.count].opacity = 0.3
    }
    
    func addHints(hints: [String]) {
        self.hints = hints
        for i in 0..<wordLength {
            letters[i].value = hints[i]
            letters[i].opacity = 0.3
        }
    }
    
    func setWord(word: Word) {
        guard word.letters.count == self.wordLength else {return}
        self.word = word.word
        for i in 0..<self.wordLength {
            self.letters[i].value = word.letters[i]
        }
    }
    
    // MARK: Visual Functions
    /// Resets all values in the word
    func reset(animationLength: Double, speed: Double = 1.0) {
        var counter = 0
        for letter in letters.reversed() {
            DispatchQueue.main.asyncAfter(deadline: .now() + ((animationLength / speed) * Double(counter)), execute: {
                withAnimation(.linear(duration: animationLength)) {
                    letter.reset()
                }
            })
            counter += 1
        }
    }
    
    /// Shakes the word if invalid
    func invalidWord() {
        withAnimation(.easeInOut(duration: 0.3)) {
            shake = true
        }
        shake = false
    }
    
    // MARK: Background Functions
    /// Sets the background colors for the row
    func setBackgrounds(letterBackgrounds: [Color]) {
        for i in 0..<letterBackgrounds.count {
            letters[i].borderColor = BorderColor.clear
            letters[i].backgroundColor = letterBackgrounds[i]
        }
    }
    
    /// Sets the background colors for the row
    func setBackgroundsWithAnimation(letterBackgrounds: [Color]) {
        for i in 0..<letters.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.125 * Double(i)), execute: {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.letters[i].borderColor = BorderColor.clear
                    self.letters[i].backgroundColor = letterBackgrounds[i]
                }
            })
        }
    }
}
