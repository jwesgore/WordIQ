import Foundation
import SwiftUI

class ZenGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {
    @Published var activeView: ActiveView
    
    override init(options: GameModeOptions) {
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.countUp = true
    }
    
    func endGame() {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(
            gameMode: .zengame,
            gameResult: .win,
            gameDifficulty: super.difficulty,
            
            numCorrectWords: 1,
            numValidGuesses: super.numValidGuesses,
            numInvalidGuesses: super.numInvalidGuesses,
            
            timeLimit: nil,
            timeElapsed: super.timerVM.timeElapsed,
            timeRemaining: nil,
            
            correctWord: super.wordsCollection.selectedWord.word,
            lastGuessedWord: super.wordsCollection.selectedWord.word
        )
        
        super.gameOverVM.setResults(results: gameOverResults)
    }
    
    // MARK: WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(guessWord: Word, valid: Bool) {
        guard valid else { return }
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            self.endGame()
            self.activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            super.keyboardVM.keyboardActive = false
            super.gameboardVM.emptyBoardWithAnimation(loadHints: true, delay: 0.75) {
                super.keyboardVM.keyboardActive = true
            }
        }
    }
    
    // MARK: GameOver Observer Functions
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        self.activeView = .standardgame
        self.gameOver()
        super.wordsCollection.updateSelectedWord()
        super.timerVM.resetTimer()
    }
    
    func mainMenu() {
        self.activeView = ActiveView.tabview
    }
}
