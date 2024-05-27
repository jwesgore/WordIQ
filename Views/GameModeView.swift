import SwiftUI

struct GameModeView: View {
    @StateObject var model: WordGameVM
    @ObservedObject var transitions: Transitions
    
    let endGame: (ActiveView) -> Void
    let title: String
    let options: GameModeOptions
    
    init(endGame: @escaping (ActiveView) -> Void, options: GameModeOptions) {
        
        switch(options.selectedMode) {
        case .standardgame:
            self._model = StateObject(wrappedValue: StandardGameVM(options: options))
            self.title = GameMode.standardgame.value
        case .rushgame:
            self._model = StateObject(wrappedValue: RushGameVM(options: options))
            self.title = GameMode.rushgame.value
        case.frenzygame:
            self._model = StateObject(wrappedValue: FrenzyGameVM(options: options))
            self.title = GameMode.frenzygame.value
        case .zengame:
            self._model = StateObject(wrappedValue: ZenGameVM(options: options))
            self.title = GameMode.zengame.value
        default:
            self._model = StateObject(wrappedValue: StandardGameVM(options: options))
            self.title = GameMode.standardgame.value
        }
        
        self.options = options
        self.endGame = endGame
        self.transitions = Transitions(activeView: options.selectedMode)
    }
   
    var body: some View {
        ZStack{
            switch transitions.activeView {
            case .gameover:
                GameOver(model: model.gameOverVM)
            case .pause:
                PauseMenuView()
            case .standardgame, .rushgame, .frenzygame, .zengame:
                VStack {
                    Spacer()
                        .frame(maxHeight: 10)
                    
                    // MARK: TOP BAR
                    HStack{
                        Text(title)
                            .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title1)))
                        Spacer()
                        Button(action: {
                            model.pause()
                        }, label:{
                            Image(systemName:SFAssets.pause)
                                .imageScale(.large)
                        })
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
        
                    // MARK: GAME SPACE
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text(String(model.exp) + " xp")
                                .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title2)))
                            Spacer()
                            TimerView(timerVM: model.timerVM)
                                .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title2)))
                                .opacity(options.selectedMode == .zengame ? 0 : 1)
                        }
                        .frame(maxWidth: 500)
                        HStack {
                            GameBoard(gameboardVM: model.gameboardVM)
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    // MARK: KEYBOARD
                    KeyboardView (keyboardViewModel: model.keyboardVM)
                        .padding()
                }
            default:
                EmptyView()
            }
        }
        .onReceive(model.$activeView) { targetView in
            if targetView == transitions.activeView {
                return
            }
            switch targetView {
            case .tabview:
                endGame(.tabview)
            case .pause:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 0.25)
            case .gameover:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 1.65)
            case .standardgame, .rushgame, .frenzygame, .zengame:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 0.25)
            default:
                return
            }
        }
    }
}

#Preview {
    GameModeView(endGame: {_ in}, options: GameModeOptions(wordLength: 5, boardSize: 6, timeLimit: 0, wordList: WordLists.fiveMedium))
}

