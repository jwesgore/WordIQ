import SwiftUI

struct FrenzyGameView: View {
    @StateObject var frenzyGameVM: FrenzyGameVM
    @ObservedObject var transitions: Transitions
    
    let endGame: (ActiveView) -> Void
    
    init(endGame: @escaping (ActiveView) -> Void, options: GameModeOptions) {
        self._frenzyGameVM = StateObject(wrappedValue: FrenzyGameVM(options: options))
        
        self.endGame = endGame
        self.transitions = Transitions(activeView: .standardgame)
    }
   
    var body: some View {
        ZStack{
            switch transitions.activeView {
            case .gameover:
                GameOver(model: frenzyGameVM.gameOverVM)
            case .standardgame:
                VStack {
                    ZStack{
                        HStack{
                            Button(action: {
                                endGame(.tabview)
                            }, label:{Image(systemName:"chevron.backward")})
                            Spacer()
                            TimerView(timerVM: frenzyGameVM.timerVM)
                        }
                        
                        Text(SystemNames.frenzyMode)
                            .font(.system(size: 20))
                            .kerning(3)
                            .fontWeight(.medium)
                            .frame(width: 200, height: 50.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding()
                    
                    Spacer()
                    GameBoard(gameboardVM: frenzyGameVM.gameboardVM)
                    Spacer()
                    KeyboardView (keyboardViewModel: frenzyGameVM.keyboardVM)
                        .padding()
                }
            default:
                EmptyView()
            }
        }
        .onReceive(frenzyGameVM.$activeView) { targetView in
            if targetView == transitions.activeView {
                return
            }
            switch targetView {
            case .tabview:
                endGame(.tabview)
            case .standardgame:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 0.25)
            case .gameover:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 1.65)
            default:
                return
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.LetterBackground.standard)
    }
}

#Preview {
    FrenzyGameView(endGame: {_ in}, options: GameModeOptions(wordLength: 5, boardSize: 6, wordList: WordLists.fiveMedium))
}

