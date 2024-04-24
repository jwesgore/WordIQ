import Foundation

class StandardGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {
    
    @Published var activeView: ActiveView
    
    override init(options: GameModeOptions) {
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.countUp = true
    }
    
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(win: true)
            self.activeView = .gameover
        }
        else if !gameboardVM.nextGuess() {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(win: false)
            self.activeView = .gameover
        }
    }
    
    /// Build contents to display on game over screen
    func endGame(win: Bool) {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(gameMode: .standardgame,
                                            timeElapsed: super.timerVM.timeElapsed,
                                            timeRemaining: super.timerVM.currentTime,
                                            correctWord: super.wordsCollection.selectedWord.word,
                                            win: win)
        
        super.gameOverVM.setResults(results: gameOverResults)
    }
    
    // MARK: GameOver Observer Function
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        self.activeView = .standardgame
        super.gameOver()
        super.wordsCollection.updateSelectedWord()
    }
    
    func mainMenu() {
        self.activeView = .tabview
    }
    
}
