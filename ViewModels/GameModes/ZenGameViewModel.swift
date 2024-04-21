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
    
    func addGameOverContents() {
        gameOverVM.reset()
        let numberOfGuesses = gameboardVM.currentPosition

        gameOverVM.addResult(result: "You Win!")

        let row1 = ["image": "pencil.line", "title": "Answer", "value": wordsCollection.selectedWord.word.uppercased()]
        let row2 = ["image": "number.square", "title": "Guesses", "value": String(numberOfGuesses)]
        
        gameOverVM.addContentsRow(row: row1)
        gameOverVM.addContentsRow(row: row2)
    }
    
    // MARK: WordsColletions Functions
    // Check currentGuess for validity
    func submitGuess(_ guessWord: Word) {
        
        // is it the correct word
        if wordsCollection.isCorrectWord(guessWord) {
            keyboardVM.keyboardActive = false
            addGameOverContents()
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
