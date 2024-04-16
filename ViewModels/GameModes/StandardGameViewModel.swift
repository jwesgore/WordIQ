import Foundation

class StandardGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {
    
    @Published var activeView: ActiveView
    
    override init(boardSize: Int, wordLength: Int, wordsFile: String) {
        self.activeView = .standardgame
        
        super.init(boardSize: boardSize, wordLength: wordLength, wordsFile: wordsFile)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
    }
    
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            buildGameOverScreen(win: true)
            activeView = .gameover
        }
        else if !gameboardVM.nextGuess() {
            keyboardVM.keyboardActive = false
            buildGameOverScreen(win: false)
            activeView = .gameover
        }
    }
    
    func buildGameOverScreen(win: Bool) {
        gameOverVM.reset()
        var numberOfGuesses = String(gameboardVM.currentPosition + 1)
        if win {
            gameOverVM.addResult(result: "You Win!")
        } else {
            gameOverVM.addResult(result: "Game Over")
            numberOfGuesses = "DNF"
        }
        
        let row1 = ["image": "pencil.line", "title": "Answer", "value": wordsCollection.selectedWord.word.uppercased()]
        let row2 = ["image": "number.square", "title": "Guesses", "value": numberOfGuesses]
        
        gameOverVM.addContentsRow(row: row1)
        gameOverVM.addContentsRow(row: row2)
    }
    
    /// GameOver Observer Function
    /// Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = .standardgame
        gameOver()
        wordsCollection.updateSelectedWord()
    }
    
    /// GameOver Observer Function
    func mainMenu() {
        activeView = .tabview
    }
    
}
