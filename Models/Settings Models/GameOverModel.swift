import Foundation

struct GameOverModel {
    var gameMode: GameMode = .null
    var gameResult: GameOverResult = .null
    var gameDifficulty: GameDifficulty = .null
    
    var numCorrectWords: Int = 0
    var numValidGuesses: Int = 0
    var numInvalidGuesses: Int = 0
    
    var date: Date?
    var timeLimit: Int?
    var timeElapsed: Int = 0
    var timeRemaining: Int?
    var xp: Int = 0
    
    var correctWord: String = ""
    var lastGuessedWord: String = ""
}
