struct GameOverModel {
    var gameMode: GameMode = .empty
    var numGuesses: Int = 0
    var timeElapsed: Int = 0
    var timeRemaining: Int = 0
    
    var correctWord: String = ""
    var lastGuessedWord: String = ""
    
    var result: GameOverResult = .gameover
    
    var numCorrectWords: Int = 0
}
