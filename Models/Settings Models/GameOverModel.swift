struct GameOverModel {
    var gameMode: GameMode = .null
    var gameResult: GameOverResult = .null
    var gameDifficulty: GameDifficulty = .null
    
    var numCorrectWords: Int = 0
    var numValidGuesses: Int = 0
    var numInvalidGuesses: Int = 0
    
    var timeLimit: Int?
    var timeElapsed: Int = 0
    var timeRemaining: Int?
    
    var correctWord: String = ""
    var lastGuessedWord: String = ""
}
