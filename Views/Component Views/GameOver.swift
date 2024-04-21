import SwiftUI

struct GameOver: View {
    
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack{
            
            // Title
            Text(model.result)
                .font(.title)
            
            // Statistical contents
            VStack {
                ForEach(model.contents, id:\.self) { line in
                    GameOverStat(image: line["image"]!, title: line["title"]!, value: line["value"]!)
                }
            }
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(BorderColor.active, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.vertical, 20)
            
            // MARK: Buttons
            GameOverButton(buttonText: "Play Again", buttonAction: model.playAgain)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 25.0))
                .foregroundStyle(Color.Text.textColoredBackground)
            
            GameOverButton(buttonText: "Main Menu", buttonAction: model.mainMenu)
                .foregroundStyle(Color.Text.text)
        }
        .frame(width:ScreenSize.width! * 0.9)
    }
}

private struct GameOverStat: View{
    let image: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(title)
            Spacer()
            Text(value)
        }
        .padding(.vertical)
    }
}

private struct GameOverButton: View {
    let buttonText: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button( action: {
            buttonAction()
        }, label: {
            Text(buttonText)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize.height! * 0.055)
        })
    }
}

#Preview {
    GameOver(model: GameOverVM())
}
