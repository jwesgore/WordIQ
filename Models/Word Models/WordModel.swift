import Foundation
import SwiftUI

class Word: Equatable{
    
    var word: String
    var letters: [String]
    
    init(_ word: String) {
        self.word = word.lowercased()
        self.letters = word.map { String($0).lowercased() }
    }
    
    static func == (_ lhs: Word, _ rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
    
    func getLetterCount() -> [String: Int] {
        var letterCount = [String: Int]()
        for letter in letters {
            letterCount[letter, default: 0] += 1
        }
        return letterCount
    }
}
