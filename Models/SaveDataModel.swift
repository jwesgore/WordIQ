import Foundation
import SwiftData

@Model
class GameData {
    @Attribute(.unique) var id: String
    
    var gameResult: GameOverResult
    var gameMode: GameMode
    var gameDifficulty: GameDifficulty
    
    var numCorrectWords: Int
    var numValidGuesses: Int
    var numInvalidGuesses: Int

    var timeLimit: Int?
    var timeElapsed: Int
    var date: Date
    
    init(id: String, gameResult: GameOverResult, gameMode: GameMode, gameDifficulty: GameDifficulty, numCorrectWords: Int, numValidGuesses: Int, numInvalidGuesses: Int, timeLimit: Int? = nil, timeElapsed: Int, date: Date) {
        
        // MARK: Values set automatically
        self.id = UUID().uuidString
        self.date = Date()
        
        // MARK: Game Identifier Values
        self.gameResult = gameResult
        self.gameMode = gameMode
        self.gameDifficulty = gameDifficulty
        
        // MARK: Guess related Values
        self.numCorrectWords = numCorrectWords
        self.numValidGuesses = numValidGuesses
        self.numInvalidGuesses = numInvalidGuesses
        
        // MARK: Time related values
        self.timeLimit = timeLimit
        self.timeElapsed = timeElapsed
        
    }
}
