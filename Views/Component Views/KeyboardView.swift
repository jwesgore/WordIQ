//
//  Keyboard.swift
//  testWordle
//
//  Created by Wesley Gore on 3/27/24.
//

import Foundation
import SwiftUI

struct KeyboardElement: View {
    @ObservedObject var key: KeyboardKey
    var viewModel: KeyboardVM
    
    let fontSize: CGFloat = 15
    let corenerRadius: CGFloat = 8
    
    var body: some View {
        Button (action: {
            viewModel.keyPressed(key: key.value)
        }, label: {
            if let textView = key.view as? Text {
                textView
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            } else if let imageView = key.view as? Image {
                imageView
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            }
        })
        .font(.system(size: fontSize))
        .fontWeight(.semibold)
        .foregroundColor(.black)
        .padding(1)
        .frame(width: key.frameWidth, height: key.frameHeight)
        .background(key.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: corenerRadius)
                .stroke(Color.gray, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: corenerRadius))
    }
}

struct KeyboardRow: View {
    var rowElements: [KeyboardKey]
    let viewModel: KeyboardVM
    
    var body: some View {
        HStack {
            ForEach(rowElements.indices, id: \.self) { index in
                KeyboardElement(key: rowElements[index], viewModel: viewModel)
                    .padding(-2)
            }
        }
    }
}

struct KeyboardView: View {
    @ObservedObject var keyboardViewModel: KeyboardVM
   
    var body: some View{
    
        VStack{
            KeyboardRow(rowElements: keyboardViewModel.topRow, viewModel: keyboardViewModel)
                .frame(maxWidth: .infinity)
            KeyboardRow(rowElements: keyboardViewModel.middleRow, viewModel: keyboardViewModel)
                .frame(maxWidth: .infinity)
            KeyboardRow(rowElements: keyboardViewModel.bottomRow, viewModel: keyboardViewModel)
                .frame(maxWidth: .infinity)
        }
      
    }
}

#Preview(body: {
    KeyboardView(keyboardViewModel: KeyboardVM())
})
