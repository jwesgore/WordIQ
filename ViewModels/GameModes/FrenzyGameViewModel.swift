import Foundation
import SwiftUI

class FrenzyGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver, TimerVMObserver {
    var correctWords = [Word]()
    let timeAddition = 10
    let timePenalty = -5
    
    override init(options: GameModeOptions) {
        
        super.init(options: options)
        super.pauseVM.quitFunction = self.quitGame
        super.pauseVM.backFunction = self.back
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.postInitSetTotalTime(time: options.timeLimit)
        super.timerVM.addObserver(observer: self)
    }
    
    func endGame() {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(
            gameMode: .frenzygame,
            gameResult: .gameover,
            gameDifficulty: super.difficulty,
            
            numCorrectWords: self.correctWords.count,
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
    
    // MARK: WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(guessWord: Word, valid: Bool) {
        guard valid else {
            super.timerVM.addTime(timePenalty)
            return
        }
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            self.correctWords.append(guessWord)
            super.timerVM.addTime((gameboardVM.boardSize - gameboardVM.currentPosition - 1) * timeAddition)
            super.gameboardVM.emptyBoardWithAnimation(delay: 0.75) {
                super.gameOver()
                super.wordsCollection.updateSelectedWord()
            }
        } else if !gameboardVM.nextGuess() {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame()
            self.activeView = .gameover
        }
    }
    
    override func quitGame() {
        self.timeOver()
    }
    
    // MARK: GameOver Observer Functions
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        self.activeView = .standardgame
        self.correctWords.removeAll()
        
        super.gameOver()
        super.wordsCollection.updateSelectedWord()
        super.timerVM.resetTimer()
    }
    
    // Go to Main Menu
    func mainMenu() {
        self.activeView = ActiveView.tabview
    }
    
    // MARK: Timer Observer Functions
    // Game Over due to time out
    func timeOver() {
        super.keyboardVM.keyboardActive = false
        self.endGame()
        self.activeView = .gameover
    }
}
