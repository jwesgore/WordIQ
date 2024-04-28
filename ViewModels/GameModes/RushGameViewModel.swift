import Foundation
import SwiftUI

class RushGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver, TimerVMObserver {
    @Published var activeView: ActiveView
    var timerActive = false
    
    override init(options: GameModeOptions) {
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.postInitSetTotalTime(time: options.timeLimit)
        super.timerVM.addObserver(observer: self)
    }
    
    // Check currentGuess for validity
    func submitGuess(guessWord: Word, valid: Bool) {
        guard valid else { return }
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(result: .win)
            self.activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            super.keyboardVM.keyboardActive = false
            super.gameboardVM.emptyBoardWithAnimation(loadHints: true, delay: 0.75) {
                super.keyboardVM.keyboardActive = true
            }
        }
    }
    
    func endGame(result: GameOverResult) {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(
            gameMode: .rushgame,
            gameResult: result,
            gameDifficulty: super.difficulty,
            
            numCorrectWords: 1,
            numValidGuesses: super.numValidGuesses,
            numInvalidGuesses: super.numInvalidGuesses,
            
            timeLimit: super.timerVM.timeLimit,
            timeElapsed: super.timerVM.timeElapsed,
            timeRemaining: super.timerVM.timeRemaining,
            
            correctWord: super.wordsCollection.selectedWord.word,
            lastGuessedWord: super.wordsCollection.selectedWord.word
        )
        
        super.gameOverVM.setResults(results: gameOverResults)
    }
    
    // MARK: GameOver Observer Function
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        self.activeView = .standardgame
        super.gameOver()
        super.wordsCollection.updateSelectedWord()
        super.timerVM.resetTimer()
    }
    
    func mainMenu() {
        self.activeView = ActiveView.tabview
    }
    
    // MARK: Timer Observer Function
    func timeOver() {
        super.keyboardVM.keyboardActive = false
        self.endGame(result: .lose)
        self.activeView = .gameover
    }
}
