import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    
    var body: some View {
        VStack (spacing: 15) {
            // MARK: Mode Info
            GameSelectModeInfo(mode: .standardgame)
            //GameSelectModeInfo(mode: gameSelectVM.activeView.toGameMode)
            
            // MARK: Game Difficulty Buttons
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.easy, list: gameSelectVM.options.wordList) {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveEasy, difficulty: .easy)
            }
            
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.medium, list: gameSelectVM.options.wordList) {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveMedium, difficulty: .normal)
            }
            
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.hard, list: gameSelectVM.options.wordList) {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveHard, difficulty: .hard)
            }
            
            // MARK: Game Time Buttons
            if gameSelectVM.activeView == .rushgame {
                GameSelectOptionsTime(gameSelectVM: gameSelectVM, times: gameSelectVM.gameOptionsSelect.rushModeTimes)
            } else if gameSelectVM.activeView == .frenzygame {
                GameSelectOptionsTime(gameSelectVM: gameSelectVM, times: gameSelectVM.gameOptionsSelect.frenzyModeTimes)
            }
            
            Spacer()
            
            // MARK: Submit and Back Buttons
            GameSelectOptionsNavButtons(text: SystemNames.startGame, 
                    backgroundColor: Color.Buttons.blueFunction,
                    borderColor: Color.Border.blueFunction ,
                    foregroundColor: Color.Text.textColoredBackground,
                    action: {gameSelectVM.startGame(gameSelectVM.activeView)})
            GameSelectOptionsNavButtons(text: SystemNames.back,
                backgroundColor: Color.Buttons.gameModeSelect,
                borderColor: Color.Border.bcGameModeSelect, 
                foregroundColor: Color.Text.text,
                action: {gameSelectVM.gotoModes()})
        }
        .frame(maxWidth: UISize.main.maxWidth)
        .padding(.horizontal, UISize.main.sectionSidePadding)
        .padding(.bottom, UISize.main.sectionSidePadding)
    }
    
}

private struct GameSelectModeInfo: View {
    
    let mode: String
    let description: String
    
    var body: some View {
        VStack {
            Text(mode)
                .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title)))
                .padding(.bottom, 5)
            HStack{
                Text(description)
                    .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.subheading)))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
        .padding(.bottom)
    }
    
    init(mode: GameMode) {
        self.mode = mode.value
        self.description = mode.description
    }
}

private struct GameSelectOptionsNavButtons: View {
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

private struct GameSelectOptionsDifficulty: View{
    
    let diffParams: DifficultyParams
    let list: String
    let action: () -> Void
    
    let height: CGFloat = 50
    let width: CGFloat = 500
    let delay: Double = 0.0
    
    var body: some View {
        
        ThreeDButton(height: height, 
                     width: width,
                     delay: delay,
                     isPressed: list == diffParams.list,
                     radio: true,
                     action: action,
                     contents:
        AnyView(
            // MARK: Title
            VStack {
                HStack{
                    Spacer()
                        .frame(width: 20)
                    
                    Text(diffParams.label)
                        .font(.custom(UIFonts.RobotoSlab.semiBold, size: CGFloat(UIFonts.Size.title2)))
                        .foregroundStyle(Color.Text.text)
                        .opacity(0.8)
                    
                    Spacer()
                }
            }
        ))
        .frame(maxHeight: ScreenSize.height! * 0.06)
    }
}

private struct GameSelectOptionsTime: View {
    
    @ObservedObject var gameSelectVM: GameSelectVM
    var times: [String: Int]
    
    let delay: Double = 0.0
    
    var body: some View {
        
        HStack {
            ForEach(times.sorted(by: { $0.value < $1.value }), id: \.key) { k, v in
                ThreeDButton(height: 50,
                             width: 500,
                             delay: delay,
                             isPressed: gameSelectVM.options.timeLimit == v, 
                             radio: true,
                             action: {gameSelectVM.setTime(time: v)}, 
                             contents:
                AnyView(
                    ZStack {
                        Text(k)
                            .font(.custom(UIFonts.RobotoSlab.regular, size:CGFloat(UIFonts.Size.headline)))
                    }
                ))
            }
        }
        .frame(maxHeight: ScreenSize.height! * 0.06)
    }
}

#Preview {
    GameSelectOptionsView(gameSelectVM: GameSelectVM())
}
