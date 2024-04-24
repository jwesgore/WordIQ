import SwiftUI

struct GameOver: View {
    
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack{
            
            // MARK: Title
            GameOverTitleView(model: model)
            
            // MARK: Statistical contents
            ForEach(model.bodyContents.indices, id:\.self) {
                GameOverStatView(gameOverStat: model.bodyContents[$0])
            }
            
            // MARK: Buttons
            GameOverButtonView(buttonText: "Play Again", buttonAction: model.playAgain)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 25.0))
                .foregroundStyle(Color.Text.textColoredBackground)
            
            GameOverButtonView(buttonText: "Main Menu", buttonAction: model.mainMenu)
                .foregroundStyle(Color.Text.text)
        }
        .frame(width:ScreenSize.width! * 0.9)
    }
}

private struct GameOverTitleView: View {
    @ObservedObject var model: GameOverVM
    
    var body: some View {
     
        HStack(spacing: 4){
            ForEach(model.title.letters) {
                GameSquare(letter: $0)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.model.setTitleBackground()
            })
        }
    }
}


private struct GameOverStatView: View{
    let gameOverStat: GameOverStat
    
    var body: some View {
        HStack {
            Image(systemName: gameOverStat.image)
            Text(gameOverStat.label)
            Spacer()
            Text(gameOverStat.value)
        }
        .padding(.vertical)
    }
}

private struct GameOverButtonView: View {
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
