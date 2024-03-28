//
//  Keyboard.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct KeyboardElement: View {
    let value: String
    let fontSize: CGFloat = 24
    
    var action: (String) -> Void
    
    var body: some View {
        Button(value) {
            self.action(value)
        }
        .font(.system(size: fontSize))
    }
}

struct Keyboard: View {
    
    var action: (String) -> Void
    
    let topRow = ["Q","W","E","R","T","Y","U","I","O","P"]
    let middleRow = ["A","S","D","F","G","H","J","K","L"]
    let bottomRow = ["Enter","Z","X","C","V","B","N","M","Del"]
    
    var body: some View{
        VStack{
            HStack{ // Top row of Keyboard
                ForEach(topRow, id: \.self) {
                    element in KeyboardElement(value: element){
                        newMessage in self.action(newMessage)
                    }
                }
            }
            HStack{ // Middle row of Keyboard
                ForEach(middleRow, id: \.self) {
                    element in KeyboardElement(value: element){
                        newMessage in self.action(newMessage)
                    }
                }
            }
            HStack{ // Bottom row of Keyboard
                ForEach(bottomRow, id: \.self) {
                    element in KeyboardElement(value: element){
                        newMessage in self.action(newMessage)
                    }
                }
            }
        }
    }
}
