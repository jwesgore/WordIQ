import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    
    var body: some View {
        VStack (spacing: 15) {
            
            // MARK: Info Box
            GameSelectModeInfo(mode: gameSelectVM.activeView.toGameMode)
                .frame(width: ScreenSize.width! * 0.9)
            //GameSelectModeInfo(mode: .standardgame)
            
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
            VStack {
                ThreeDButton(
                 height: ScreenSize.height! * 0.055, 
                 width: .infinity,
                 backgroundColor: .blue,
                 borderColor: Color(.blue).opacity(0.6),
                 delay: 0.1,
                 speed: 0.05,
                 action: {
                    gameSelectVM.startGame(gameSelectVM.activeView)
                }, contents:
                AnyView(
                    ZStack {
                        HStack {
                            Spacer()
                            Text(SystemNames.startGame)
                                .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
                                .foregroundStyle(Color.Text.textColoredBackground)
                            Spacer()
                        }
                    }
                    .frame(height: ScreenSize.height! * 0.055)
                ))
                
//                Button(action: {
//                    gameSelectVM.startGame(gameSelectVM.activeView)
//                }, label: {
//                    GameSelectOptionsNavButtons(text: SystemNames.startGame, backgroundColor: .blue, foregroundColor: Color.Text.textColoredBackground)
//                })
                
                Button(action: {
                    gameSelectVM.gotoModes()
                }, label: {
                    GameSelectOptionsNavButtons(text: SystemNames.back, backgroundColor: .clear, foregroundColor: Color.Text.text)
                })
            }
            .frame(maxWidth: ScreenSize.width! * 0.9)
            .padding(.bottom)
           
        }
    }
}

private struct GameSelectModeInfo: View {
    
    let mode: String
    let description: String
    
    var body: some View {
        GroupBox {
            VStack {
                Text(mode)
                    .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title)))
                    .padding(.bottom, 10)
                HStack {
                    Text(description)
                        .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
                    Spacer()
                }
            }
        }
    }
    
    init(mode: GameMode) {
        self.mode = mode.value
        self.description = mode.description
    }
}

private struct GameSelectOptionsNavButtons: View {
    var text: String
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.headline)))
            .frame(maxWidth: .infinity, maxHeight: ScreenSize.height! * 0.055)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 25.0))
            .foregroundStyle(foregroundColor)
    }
}

private struct GameSelectOptionsDifficulty: View{
    
    let diffParams: DifficultyParams
    let list: String
    let action: () -> Void
    
    let height: CGFloat = ScreenSize.height! * 0.06
    let width: CGFloat = ScreenSize.width! * 0.9
    let delay: Double = 0.0
    
    var body: some View {
        
        ThreeDButton(height: height, width: width, delay: delay, isPressed: list == diffParams.list, radio: true, action: action, contents: AnyView(
            ZStack {
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
                .frame(width: width, height: height)
            }
        ))
    }
}

private struct GameSelectOptionsTime: View {
    
    @ObservedObject var gameSelectVM: GameSelectVM
    var times: [String: Int]
    
    let delay: Double = 0.0
    
    var body: some View {
        
        HStack {
            ForEach(times.sorted(by: { $0.value < $1.value }), id: \.key) { k, v in
                ThreeDButton(height: .infinity, width: .infinity, delay: delay, isPressed: gameSelectVM.options.timeLimit == v, radio: true, action: {gameSelectVM.setTime(time: v)}, contents: AnyView(
                    ZStack {
                        Text(k)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                ))
            }
        }
        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.06)
    }
}

#Preview {
    GameSelectOptionsView(gameSelectVM: GameSelectVM())
}
