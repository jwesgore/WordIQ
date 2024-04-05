//
//  Enums.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

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
    case empty
}

enum KeyboardEntryType {
    case enter
    case delete
    case letter
}
