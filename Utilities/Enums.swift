import Foundation
import SwiftUI

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
