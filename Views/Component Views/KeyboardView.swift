import Foundation
import SwiftUI

/// View of the entire keyboard containing a top, middle, and bottom row
struct KeyboardView: View {
    @ObservedObject var keyboardViewModel: KeyboardVM
    
    var body: some View{
        VStack{
            KeyboardRow(rowElements: keyboardViewModel.topRow, viewModel: keyboardViewModel)
            KeyboardRow(rowElements: keyboardViewModel.middleRow, viewModel: keyboardViewModel)
            KeyboardRow(rowElements: keyboardViewModel.bottomRow, viewModel: keyboardViewModel)
        }
    }
}

/// View of a single row of the keyboard
struct KeyboardRow: View {
    var rowElements: [BaseComponent]
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

/// View of a single key on a keyboard
struct KeyboardElement: View {
    @ObservedObject var key: BaseComponent
    var viewModel: KeyboardVM
    
    var body: some View {
        let buttonView = ImageOrText(component: key)

        Button (action: {
            viewModel.keyPressed(key: key.value)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }, label: {
            buttonView
                .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .foregroundStyle(Color.Text.text)
                .font(.system(size: key.fontSize))
                .fontWeight(.semibold)
        })
        .padding(1)
        .frame(width: key.width, height: key.height)
        .background(key.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: key.cornerRadius)
                .stroke(Color.gray, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: key.cornerRadius))
    }
}

extension KeyboardElement {
    @ViewBuilder
    func ImageOrText(component: BaseComponent) -> some View {
        if let x = component as? Letter {
            x.view
        }
        else if let x = component as? Function {
            x.view
        }
    }
}

#Preview(body: {
    KeyboardView(keyboardViewModel: KeyboardVM())
})
