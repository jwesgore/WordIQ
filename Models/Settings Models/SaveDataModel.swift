import Foundation
import SwiftData

//@Model
//class GameData {
//    @Attribute(.unique) var id: String
//    
//    var gameMode: String
//    var gameResult: String
//    var gameDifficulty: String
//    
//    var numCorrectWords: Int
//    var numValidGuesses: Int
//    var numInvalidGuesses: Int
//
//    var timeLimit: Int?
//    var timeElapsed: Int
//    var date: Date
//    
//    init(id: String, gameResult: GameOverResult, gameMode: GameMode, gameDifficulty: GameDifficulty, numCorrectWords: Int, numValidGuesses: Int, numInvalidGuesses: Int, timeLimit: Int? = nil, timeElapsed: Int, date: Date) {
//        // MARK: Values set automatically
//        self.id = UUID().uuidString
//        self.date = Date()
//        
//        // MARK: Game Identifier Values
//        self.gameResult = gameResult.rawValue
//        self.gameMode = gameMode.rawValue
//        self.gameDifficulty = gameDifficulty.rawValue
//        
//        // MARK: Guess related Values
//        self.numCorrectWords = numCorrectWords
//        self.numValidGuesses = numValidGuesses
//        self.numInvalidGuesses = numInvalidGuesses
//        
//        // MARK: Time related values
//        self.timeLimit = timeLimit
//        self.timeElapsed = timeElapsed
//    }
//    
//    init (gameOverModel: GameOverModel) {
//        // MARK: Values set automatically
//        self.id = UUID().uuidString
//        self.date = Date()
//        
//        // MARK: Game Identifier Values
//        self.gameResult = gameOverModel.gameResult.rawValue
//        self.gameMode = gameOverModel.gameMode.rawValue
//        self.gameDifficulty = gameOverModel.gameDifficulty.rawValue
//        
//        // MARK: Guess related Values
//        self.numCorrectWords = gameOverModel.numCorrectWords
//        self.numValidGuesses = gameOverModel.numValidGuesses
//        self.numInvalidGuesses = gameOverModel.numInvalidGuesses
//        
//        // MARK: Time related values
//        self.timeLimit = gameOverModel.timeLimit
//        self.timeElapsed = gameOverModel.timeElapsed
//    }
//}
