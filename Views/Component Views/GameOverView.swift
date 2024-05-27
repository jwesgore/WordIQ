import SwiftUI
import SwiftData

struct GameOver: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack{
            // MARK: Title
            GameOverTitleView(model: model)
            
            // MARK: Statistical contents
            VStack {
                ForEach(model.bodyContents.indices, id:\.self) {
                    GameOverStatView(gameOverStat: model.bodyContents[$0])
                }
            }
            .frame(maxWidth: ScreenSize.width! * 0.9)
            .background (
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.UIElements.gameSelectButton)
            )
            .padding([.top, .bottom])
            
            // MARK: Buttons
            GameOverButtonView(text: SystemNames.playAgain,
                    backgroundColor: Color.Buttons.blueFunction,
                    borderColor: Color.Border.blueFunction ,
                    foregroundColor: Color.Text.textColoredBackground,
                    action: model.playAgain)
            .padding(.bottom)
            
            GameOverButtonView(text: SystemNames.mainMenu,
                backgroundColor: Color.Buttons.gameModeSelect,
                borderColor: Color.Border.bcGameModeSelect,
                foregroundColor: Color.Text.text,
                action: model.mainMenu)
            .padding(.bottom)
        }
        .frame(width:ScreenSize.width! * 0.9)
        .onAppear {
            switch model.results.gameMode {
            case .standardgame:
                let initmodel = StandardSaveModel(model: model.results)
                modelContext.insert(initmodel)
            case .rushgame:
                let initmodel = RushSaveModel(model: model.results)
                modelContext.insert(initmodel)
            case .frenzygame:
                let initmodel = FrenzySaveModel(model: model.results)
                modelContext.insert(initmodel)
            case .zengame:
                let initmodel = ZenSaveModel(model: model.results)
                modelContext.insert(initmodel)
            default:
                return
            }
        }
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
        .padding()
    }
}

private struct GameOverButtonView: View {
    var text: String
    var backgroundColor: Color
    var borderColor: Color
    var foregroundColor: Color
    var action: () -> Void
    
    var body: some View {
        ThreeDButton(
         height: 50,
         width: 500,
         backgroundColor: backgroundColor,
         borderColor: borderColor,
         delay: 0.0,
         speed: 0.025,
         action: {action()},
         contents:
        AnyView(
            VStack {
                HStack {
                    Text(text)
                        .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
                        .foregroundStyle(foregroundColor)
                }
            }
        ))
        .frame(maxHeight: ScreenSize.height! * 0.06)
    }
}

#Preview {
    GameOver(model: GameOverVM())
}
