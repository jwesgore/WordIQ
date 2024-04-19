import Foundation
import SwiftUI

class RushGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver, TimerVMObserver {
    @Published var activeView: ActiveView
    var timerActive = false
    
    override init(options: GameModeOptions) {
        let timeLimit = 60
        
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.postInitSetTotalTime(time: timeLimit)
        super.timerVM.addObserver(observer: self)
    }
    
    // WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            timerVM.stopTimer()
            addGameOverContents(win: true)
            activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            gameboardVM.emptyBoard(loadHints: true)
        }
    }
    
    func addGameOverContents(win: Bool) {
        gameOverVM.reset()
        let numberOfGuesses = gameboardVM.currentPosition
        
        if win {
            gameOverVM.addResult(result: "You Win!")
        } else {
            gameOverVM.addResult(result: "You Lose!")
        }
        
        let row1 = ["image": "pencil.line", "title": "Answer", "value": wordsCollection.selectedWord.word.uppercased()]
        let row2 = ["image": "timer", "title": "Time Remaining", "value": timerVM.timeToString()]
        let row3 = ["image": "number.square", "title": "Guesses", "value": String(numberOfGuesses)]
        
        gameOverVM.addContentsRow(row: row1)
        gameOverVM.addContentsRow(row: row2)
        gameOverVM.addContentsRow(row: row3)
    }
    
    /// GameOver Observer Function
    /// Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = .standardgame
        super.gameOver()
        wordsCollection.updateSelectedWord()
        timerVM.resetTimer()
    }
    
    /// GameOver Observer Function
    func mainMenu() {
        activeView = ActiveView.tabview
    }
    
    /// Timer Observer Function
    func timeOver() {
        keyboardVM.keyboardActive = false
        addGameOverContents(win: false)
        activeView = .gameover
    }
}
