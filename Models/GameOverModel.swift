import Foundation

struct GameOverModel {
    var gameMode: GameModes = .empty
    var numGuesses: Int = 0
    var timeElapsed: Int = 0
    var timeRemaining: Int = 0
    
    var correctWord: String = ""
    var lastGuessedWord: String = ""
    
    var win: Bool = false
    
    var numCorrectWords: Int = 0
}
