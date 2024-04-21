import Foundation
import SwiftUI

class FrenzyGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver, TimerVMObserver {
    @Published var activeView: ActiveView
    var correctWords = [Word]()
    
    override init(options: GameModeOptions) {
        self.activeView = .standardgame
        
        super.init(options: options)
        super.addSubclassObserver(observer: self)
        super.gameOverVM.addObserver(observer: self)
        
        super.timerVM.postInitSetTotalTime(time: options.timeLimit)
        super.timerVM.addObserver(observer: self)
    }
    
    // WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            correctWords.append(guessWord)
            print(gameboardVM.boardSize - gameboardVM.currentPosition)
            timerVM.addTime(((gameboardVM.boardSize - gameboardVM.currentPosition) - 1 ) * 10)
            super.gameOver()
            wordsCollection.updateSelectedWord()
        } else if !gameboardVM.nextGuess() {
            keyboardVM.keyboardActive = false
            timerVM.stopTimer()
            buildGameOverScreen(timeOver: false)
            activeView = .gameover
        }
    }
    
    func buildGameOverScreen(timeOver: Bool) {
        gameOverVM.reset()
        
        if timeOver {
            gameOverVM.addResult(result: "Times Up!")
        } else {
            gameOverVM.addResult(result: "You Lose!")
        }
    
        let row1 = ["image": "pencil.line", "title": "Last Word", "value": wordsCollection.selectedWord.word.uppercased()]
        let row2 = ["image": "number.square", "title": "Correct Words", "value": String(correctWords.count)]
        
        gameOverVM.addContentsRow(row: row1)
        gameOverVM.addContentsRow(row: row2)
    }
    
    /// GameOver Observer Function
    /// Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = .standardgame
        super.gameOver()
        wordsCollection.updateSelectedWord()
        timerVM.resetTimer()
        correctWords.removeAll()
    }
    
    /// GameOver Observer Function
    func mainMenu() {
        activeView = ActiveView.tabview
    }
    
    /// Timer Observer Function
    func timeOver() {
        keyboardVM.keyboardActive = false
        buildGameOverScreen(timeOver: true)
        activeView = .gameover
    }
}
