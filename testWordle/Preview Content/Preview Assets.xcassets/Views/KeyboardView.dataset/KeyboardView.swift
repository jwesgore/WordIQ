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
    
    var viewModel: KeyboardViewModel
    
    var body: some View {
        Button(value) {
            self.viewModel.keyPressed(key: value)
        }
        .font(.system(size: fontSize))
        .background(Color.white)
        .padding(4)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct KeyboardView: View {
    
    var keyboardViewModel: KeyboardViewModel
   
    var body: some View{
        VStack{
            HStack{ // Top row of Keyboard
                ForEach(keyboardViewModel.keyboardModel.topRow, id: \.self) {
                    element in KeyboardElement(value: element, viewModel: keyboardViewModel)
                }
            }
            HStack{ // Middle row of Keyboard
                ForEach(keyboardViewModel.keyboardModel.middleRow, id: \.self) {
                    element in KeyboardElement(value: element, viewModel: keyboardViewModel)
                }
            }
            HStack{ // Bottom row of Keyboard
                ForEach(keyboardViewModel.keyboardModel.bottomRow, id: \.self) {
                    element in KeyboardElement(value: element, viewModel: keyboardViewModel)
                }
            }
        }
    }
}
