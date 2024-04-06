import SwiftUI

struct WordGameFiveLetters: View {
    var endGame: (ActiveView) -> Void
    let boardSize: Int
    let wordLength: Int
    let wordsFile: String
   
    var body: some View {
        let wordGameVM = WordGameVM(boardSize: self.boardSize, wordLength: self.wordLength, wordsFile: self.wordsFile)
        
        ZStack{
            VStack {
                HStack{
                    Button(action: {
                        endGame(ActiveView.tabview)
                    }, label:{Image(systemName:"chevron.backward")})
                    Spacer()
                }
                .padding()
                
                GameBoard(gameViewModel: wordGameVM.gameboardVM)
                Spacer()
                KeyboardView (keyboardViewModel: wordGameVM.keyboardVM)
                    .padding()
            }
            
            GameOver(model: wordGameVM.gameOverVM)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        }
        
        
    }
}

#Preview {
    WordGameFiveLetters(endGame: {_ in}, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
}

