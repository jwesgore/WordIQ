import Foundation
import SwiftUI

enum SystemNames {
    static let title = "Word Game"
    static let standardMode = "Standard"
    static let rushMode = "Rush"
    static let frenzyMode = "Frenzy"
    static let zenMode = "Zen"
}

enum LetterComparison{
    case wrongLetter
    case differentPosition
    case samePosition
}

enum ActiveView {
    case tabview
    case wordgame
    case gameover
    case empty
}

enum KeyboardEntryType {
    case enter
    case delete
    case letter
}
