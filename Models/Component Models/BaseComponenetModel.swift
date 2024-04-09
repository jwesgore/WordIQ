import Foundation
import SwiftUI

enum BorderColor {
    static let active = Color("BCActive")
    static let inactive = Color("BCInactive")
    static let clear = Color(.clear)
}

enum LetterBackgroundColor {
    static let correct = Color("Correct")
    static let incorrect = Color("Incorrect")
    static let contains = Color("Contains")
    static let standard = Color("Standard")
    static let error = Color("Error")
}

enum FunctionImages {
    static let delete = "arrow.backward"
    static let enter = "arrow.turn.down.right"
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
    
    init(backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat, fontSize: CGFloat = 15, cornerRadius: CGFloat = 8, constraint: CGFloat = 100.0) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.width = width > constraint ? constraint : width
        self.height = height > constraint ? constraint : height
        
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
    
    init(value: String, backgroundColor: Color = .clear, borderColor: Color = .clear, width: CGFloat, height: CGFloat, constraint: CGFloat = 100.0) {
        self.view = Image(systemName: value)
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height, constraint: constraint)
        super.value = value
    }
}
