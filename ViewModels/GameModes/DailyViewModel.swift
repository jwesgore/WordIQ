import Foundation

class DailyGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {

    override init(options: GameModeOptions) {
        
        super.init(options: options)
        super.pauseVM.quitFunction = self.quitGame
        super.pauseVM.backFunction = self.back
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.countUp = true
    }
    
    // MARK: WordGameSubclassObserver Functions
    // Check currentGuess for validity
    func submitGuess(guessWord: Word, valid: Bool) {
        guard valid else { return }
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(result: .win)
            self.activeView = .gameover
        }
        else if !gameboardVM.nextGuess() {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(result: .lose)
            self.activeView = .gameover
        }
    }
    
    override func quitGame() {
        super.keyboardVM.keyboardActive = false
        super.timerVM.stopTimer()
        self.endGame(result: .lose)
        self.activeView = .gameover
    }
    
    /// Build contents to display on game over screen
    func endGame(result: GameOverResult) {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(
            gameMode: .daily,
            gameResult: result,
            gameDifficulty: super.difficulty,
            
            numCorrectWords: 1, 
            numValidGuesses: result == .win ? super.numValidGuesses : 7,
            numInvalidGuesses: super.numInvalidGuesses,
            date: super.date,
            
            timeLimit: nil,
            timeElapsed: super.timerVM.timeElapsed,
            timeRemaining: nil,
            
            correctWord: super.wordsCollection.selectedWord.word,
            lastGuessedWord: super.wordsCollection.selectedWord.word
        )

        super.gameOverVM.setResults(results: gameOverResults)
    }
    
    // MARK: GameOver Observer Function
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        super.activeView = .standardgame
        super.gameOver()
        super.wordsCollection.updateSelectedWord()
        super.timerVM.resetTimer()
    }
    
    func mainMenu() {
        super.activeView = .tabview
    }
    
}
