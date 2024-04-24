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
                                            win: true)
        
        super.gameOverVM.setResults(results: gameOverResults)
    }
    
    // MARK: WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            endGame()
            activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            keyboardVM.keyboardActive = false
            gameboardVM.emptyBoardWithAnimation() {
                self.keyboardVM.keyboardActive = true
            }
        }
    }
    
    // MARK: GameOver Observer Functions
    // Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = .standardgame
        gameOver()
        wordsCollection.updateSelectedWord()
    }
    
    func mainMenu() {
        activeView = ActiveView.tabview
    }
}
