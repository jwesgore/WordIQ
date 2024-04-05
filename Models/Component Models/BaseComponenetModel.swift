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

struct FunctionImages {
    let delete = "arrow.backward"
    let enter = "arrow.turn.down.right"
}

/// Superclass used to define common parrameters for base level UI elements such as letter in a word or a key on a keyboard
class BaseComponent: ObservableObject {
    @Published var value: String = ""
    @Published var backgroundColor: Color
    @Published var borderColor: Color
    @Published var width: CGFloat
    @Published var height: CGFloat
    
    @Published var fontSize: CGFloat
    @Published var cornerRadius: CGFloat
    
    init(backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat, fontSize: CGFloat = 15, cornerRadius: CGFloat = 8) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.width = width
        self.height = height
        
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
    }
}

/// Subclass of BaseComponent used for holding items that operate as letters such as gameboard or keyboard pieces
class Letter: BaseComponent {
    @Published var view: Text
    
    init(value: String, backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat) {
        self.view = Text(value)
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height)
        super.value = value
    }
}

/// Subclass of BaseComponent used for holding items that operate as Function Keys such as "Enter" and "Delete"
class Function: BaseComponent {
    @Published var view: Image
    
    init(value: String, backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat) {
        self.view = Image(systemName: value)
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height)
        super.value = value
    }
}
