import Foundation
import SwiftUI

/// Superclass used to define common parrameters for base level UI elements such as letter in a word or a key on a keyboard
class BaseComponent: ObservableObject, Identifiable {
    @Published var value: String = ""
    @Published var opacity: Double = 100.0
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
    @Published var submitted: Bool
    
    init(value: String, backgroundColor: Color, borderColor: Color, width: CGFloat, height: CGFloat, submitted: Bool = false) {
        self.view = Text(value)
        self.submitted = submitted
        super.init(backgroundColor: backgroundColor, borderColor: borderColor, width: width, height: height)
        super.value = value
    }
    
    func reset() {
        self.value = ""
        self.backgroundColor = Color.LetterBackground.standard
        self.borderColor = Color.Border.bcInactive
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
