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
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            super.keyboardVM.keyboardActive = false
            super.timerVM.stopTimer()
            self.endGame(win: true)
            self.activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            super.gameboardVM.emptyBoard(loadHints: true)
        }
    }
    
    func endGame(win: Bool) {
        super.gameOverVM.clearResults()
        
        let gameOverResults = GameOverModel(gameMode: .rushgame,
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
        super.timerVM.resetTimer()
    }
    
    func mainMenu() {
        self.activeView = ActiveView.tabview
    }
    
    // MARK: Timer Observer Function
    func timeOver() {
        super.keyboardVM.keyboardActive = false
        self.endGame(win: false)
        self.activeView = .gameover
    }
}
