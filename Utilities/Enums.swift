import Foundation
import SwiftUI

enum SystemNames {
    static let title = "Word Game"
    static let standardMode = "Standard"
    static let rushMode = "Rush"
    static let frenzyMode = "Frenzy"
    static let zenMode = "Zen"
}

enum WordLists {
    static let fiveEasy = "five_letter_words_easy"
    static let fiveMedium = "five_letter_words_medium"
    static let fiveHard = "five_letter_words_hard"
}

enum LetterComparison{
    case wrongLetter
    case differentPosition
    case samePosition
}

enum ActiveView {
    case tabview
    case gameover
    case empty
    case standardgame
    case rushgame
    case frenzygame
    case zengame
}

enum KeyboardEntryType {
    case enter
    case delete
    case letter
}
