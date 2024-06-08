import SwiftUI
import SwiftData

struct GameOver: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack(spacing: 4) {
            // MARK: Title
            GameOverTitleView(model: model)
            
            // MARK: Statistical contents
            GroupBox {
                // MARK:
                
                // MARK: Stats
                ForEach(model.bodyContents.indices, id:\.self) { index in
                    GameOverStatView(gameOverStat: model.bodyContents[index])
                        .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
                    if index < model.bodyContents.indices.last! {
                        Divider()
                    }
                }
            }
            .padding(.vertical, 4)
            
            // MARK: Buttons
            GameOverButtonView(text: SystemNames.playAgain,
                    backgroundColor: Color.Buttons.blueFunction,
                    borderColor: Color.Border.blueFunction ,
                    foregroundColor: Color.Text.textColoredBackground,
                    action: model.playAgain)
            
            GameOverButtonView(text: SystemNames.mainMenu,
                backgroundColor: Color.Buttons.gameModeSelect,
                borderColor: Color.Border.bcGameModeSelect,
                foregroundColor: Color.Text.text,
                action: model.mainMenu)
        }
        .frame(maxWidth: UISize.gameover.maxWidth)
        .padding(.horizontal, UISize.main.sectionSidePadding)
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
//            case .daily:
//                let initmodel = DailySaveModel(model: model.results)
//                modelContext.insert(initmodel)
            default:
                return
            }
        }
    }
}

private struct GameOverTitleView: View {
    @ObservedObject var model: GameOverVM
    
    var body: some View {
        HStack {
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
         width: UISize.gameover.maxWidth,
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
        .frame(maxHeight: 50)
        .padding(.vertical, 5)
    }
}

#Preview {
    GameOver(model: GameOverVM())
}
