//
//  KeyboardModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation
import SwiftUI

class KeyboardModel {
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let operations = ["Enter", "Del"]
    
    let topRowLetters = ["Q","W","E","R","T","Y","U","I","O","P"]
    let middleRowLetters = ["A","S","D","F","G","H","J","K","L"]
    let bottomRowLetters = ["Z","X","C","V","B","N","M"]
}

class KeyboardKey: ObservableObject {

    var view: any View
    let value: String
    let frameHeight: CGFloat
    var frameWidth: CGFloat
    @Published var backgroundColor: Color
    
    init(_ view: any View, value: String, frameHeightMultiplier: CGFloat = 0.06, frameWidthMultiplier: CGFloat = 0.085) {
        self.view = view
        self.value = value
        //self.frameHeight = frameHeight
        self.frameHeight = UIScreen.main.bounds.height * frameHeightMultiplier
        self.frameWidth = UIScreen.main.bounds.width * frameWidthMultiplier
        self.backgroundColor = Color(UIColor.systemBackground)
    }
}
