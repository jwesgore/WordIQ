import SwiftUI

struct WordGameFiveLetters: View {
    @StateObject var wordGameVM: WordGameVM
    @ObservedObject var transitions: Transitions
    
    let endGame: (ActiveView) -> Void
    
    init(endGame: @escaping (ActiveView) -> Void, boardSize: Int, wordLength: Int, wordsFile: String) {
        self._wordGameVM = StateObject(wrappedValue: WordGameVM(boardSize: boardSize, wordLength: wordLength, wordsFile: wordsFile))
        
        self.endGame = endGame
        self.transitions = Transitions(activeView: .wordgame)
    }
   
    var body: some View {
        ZStack{
            switch transitions.activeView {
            case ActiveView.gameover:
                GameOver(model: wordGameVM.gameOverVM)
            case ActiveView.wordgame:
                VStack {
                    HStack{
                        Button(action: {
                            endGame(.tabview)
                        }, label:{Image(systemName:"chevron.backward")})
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    GameBoard(gameboardVM: wordGameVM.gameboardVM)
                    Spacer()
                    KeyboardView (keyboardViewModel: wordGameVM.keyboardVM)
                        .padding()
                }
            default:
                EmptyView()
            }
        }
        .onReceive(wordGameVM.$activeView) { targetView in
            if targetView == transitions.activeView {
                return
            }
            switch targetView {
            case .tabview:
                endGame(.tabview)
            case .wordgame:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 0.25)
            case .gameover:
                transitions.fadeToWhiteDelay(targetView: targetView, delay: 1.65)
            default:
                return
            }
        }
    }
}

#Preview {
    WordGameFiveLetters(endGame: {_ in}, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
}

