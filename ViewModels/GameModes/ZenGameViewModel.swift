import Foundation
import SwiftUI

class ZenGameVM: WordGameVM, WordGameSubclassObserver, GameOverVMObserver {
    @Published var activeView: ActiveView
    //var observers: [ZenGameVMObserver]
    
    override init(boardSize: Int, wordLength: Int, wordsFile: String) {
        self.activeView = .standardgame
        
        super.init(boardSize: boardSize, wordLength: wordLength, wordsFile: wordsFile)
    }
    
    // WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            addGameOverContents(win: true)
            activeView = .gameover
        } else if !gameboardVM.nextGuess() {
            keyboardVM.keyboardActive = false
            addGameOverContents(win: false)
            activeView = .gameover
        }
    }
    
    func addGameOverContents(win: Bool) {
        gameOverVM.reset()
        var numberOfGuesses = gameboardVM.currentPosition
        if win {
            numberOfGuesses += 1
            gameOverVM.addResult(result: "You Win!")
        } else {
            gameOverVM.addResult(result: "Game Over")
        }
        
        let row1 = ["image": "pencil.line", "title": "Answer", "value": wordsCollection.selectedWord.word.uppercased()]
        let row2 = ["image": "number.square", "title": "Guesses", "value": String(numberOfGuesses)]
        
        gameOverVM.addContentsRow(row: row1)
        gameOverVM.addContentsRow(row: row2)
    }
    
    /// GameOver Observer Function
    /// Passes along which button was pressed in the GameOverView
    func playAgain() {
        activeView = ActiveView.standardgame
        gameOver()
        wordsCollection.updateSelectedWord()
    }
    
    /// GameOver Observer Function
    func mainMenu() {
        activeView = ActiveView.tabview
    }
}
