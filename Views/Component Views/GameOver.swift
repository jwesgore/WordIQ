import SwiftUI

struct GameOver: View {
    
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack{
            GameOverButton(buttonText: "Play Again", buttonAction: model.playAgain)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 25.0))
            
            GameOverButton(buttonText: "Main Menu", buttonAction: model.mainMenu)
        }
        .frame(width:ScreenSize().width! * 0.9)
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
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.05)
                .foregroundStyle(Color("TextColor"))
        })
    }
}

#Preview {
    GameOver(model:GameOverVM())
}
