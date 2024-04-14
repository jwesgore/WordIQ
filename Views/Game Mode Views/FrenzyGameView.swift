import SwiftUI

struct FrenzyGameView: View {
    @StateObject var frenzyGameVM: FrenzyGameVM
    @ObservedObject var transitions: Transitions
    
    let endGame: (ActiveView) -> Void
    
    init(endGame: @escaping (ActiveView) -> Void, boardSize: Int, wordLength: Int, wordsFile: String) {
        self._frenzyGameVM = StateObject(wrappedValue: FrenzyGameVM(boardSize: boardSize, wordLength: wordLength, wordsFile: wordsFile))
        
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
                    HStack{
                        Button(action: {
                            endGame(.tabview)
                        }, label:{Image(systemName:"chevron.backward")})
                        Spacer()
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
    FrenzyGameView(endGame: {_ in}, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
}

