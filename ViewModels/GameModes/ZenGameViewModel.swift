import Foundation
import SwiftUI

class ZenGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {
    @Published var activeView: ActiveView
    
    override init(options: GameModeOptions) {
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
    }
    
    func endGame() {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(gameMode: .zengame,
                                            timeElapsed: super.timerVM.timeElapsed,
                                            timeRemaining: super.timerVM.currentTime,
                                            correctWord: super.wordsCollection.selectedWord.word,
                                            result: .win)
        
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
    }
    
    func mainMenu() {
        self.activeView = ActiveView.tabview
    }
}
