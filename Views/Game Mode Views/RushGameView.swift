import SwiftUI

struct RushGameView: View {
    @StateObject var rushGameVM: RushGameVM
    @ObservedObject var transitions: Transitions
    
    let endGame: (ActiveView) -> Void
    
    init(endGame: @escaping (ActiveView) -> Void, boardSize: Int, wordLength: Int, wordsFile: String) {
        self._rushGameVM = StateObject(wrappedValue: RushGameVM(boardSize: boardSize, wordLength: wordLength, wordsFile: wordsFile))
        
        self.endGame = endGame
        self.transitions = Transitions(activeView: .standardgame)
    }
   
    var body: some View {
        ZStack{
            switch transitions.activeView {
            case .gameover:
                GameOver(model: rushGameVM.gameOverVM)
            case .standardgame:
                VStack {
                    ZStack{
                        HStack{
                            Button(action: {
                                endGame(.tabview)
                            }, label:{Image(systemName:"chevron.backward")})
                            Spacer()
                        }
                        
                        Text(SystemNames.rushMode)
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
                    GameBoard(gameboardVM: rushGameVM.gameboardVM)
                    Spacer()
                    KeyboardView (keyboardViewModel: rushGameVM.keyboardVM)
                        .padding()
                }
            default:
                EmptyView()
            }
        }
        .onReceive(rushGameVM.$activeView) { targetView in
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
    RushGameView(endGame: {_ in}, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
}

