//
//  LetterModel.swift
//  wordGame
//
//  Created by Wesley Gore on 4/2/24.
//

import Foundation
import SwiftUI

struct BorderColor {
    let active = Color("BCActive")
    let inactive = Color("BCInactive")
    let clear = Color(.clear)
}

struct LetterBackgroundColor {
    let correct = Color("Correct")
    let incorrect = Color("Incorrect")
    let contains = Color("Contains")
    let standard = Color("Standard")
}

/// Superclass used to define common parrameters for base level UI elements such as letter in a word or a key on a keyboard
class BaseComponent: ObservableObject {
    @Published var backgroundColor: Color
    @Published var borderColor: Color
    @Published var width: CGFloat
    @Published var height: CGFloat
    
    @Published var degrees = 0.0
    
    init(backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.width = width
        self.height = height
    }
}

/// Subclass of BaseComponent used for holding items that operate as letters such as gameboard or keyboard pieces
class Letter: BaseComponent {
    @Published var value: String
    @Published var view: Text
    
    init(value: String, backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat) {
        self.value = value
        self.view = Text(value)
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height)
    }
}

/// Subclass of BaseComponent used for holding items that operate as Function Keys such as "Enter" and "Delete"
class Function: BaseComponent {
    @Published var value: String
    @Published var view: Image
    
    init(value: String, backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat) {
        self.value = value
        self.view = Image(value)
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height)
    }
}
