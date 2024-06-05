import Foundation
import SwiftData

@Model
class DailySaveModel: DailySaveDataModelProtocol {
    
    // MARK: Daily Game Values
    var date: Date
    
    // MARK: Base Protocol Values
    var totalTimePlayed: Int
    var totalXP: Int
    var totalValidGuesses: Int
    var totalInvalidGuesses: Int
    var difficulty: GameDifficulty
    var result: GameOverResult
    
    init(date: Date, result: GameOverResult, difficulty: GameDifficulty, totalTimePlayed: Int = 0, totalXP: Int = 0, totalValidGuesses: Int = 0, totalInvalidGuesses: Int = 0) {
        // MARK: Daily Game Protocol Values
        self.date = date
        
        // MARK: Base Protocol Values
        self.result = result
        self.difficulty = difficulty
        self.totalTimePlayed = totalTimePlayed
        self.totalXP = totalXP
        self.totalValidGuesses = totalValidGuesses
        self.totalInvalidGuesses = totalInvalidGuesses
    }
    
    init(model: GameOverModel) {
        // MARK: Daily Game Protocol Values
        self.date = model.date ?? Date.now

        // MARK: Base Protocol Values
        self.result = model.gameResult
        self.difficulty = model.gameDifficulty
        self.totalTimePlayed = model.timeElapsed
        self.totalXP = model.xp
        self.totalValidGuesses = model.numValidGuesses
        self.totalInvalidGuesses = model.numInvalidGuesses
    }
}

protocol DailySaveDataModelProtocol: BaseSaveDataModelProtocol {
    var date: Date { get set }
}
