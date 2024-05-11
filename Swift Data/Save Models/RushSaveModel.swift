import SwiftData

@Model
class RushSaveModel: BaseSaveDataModelProtocol {
    // MARK: Rush Game Values
    var timeLimit: Int
    
    // MARK: Base Protocol Values
    var totalTimePlayed: Int
    var totalXP: Int
    var totalValidGuesses: Int
    var totalInvalidGuesses: Int
    var difficulty: GameDifficulty
    var result: GameOverResult
    
    init(result: GameOverResult, difficulty: GameDifficulty, totalTimePlayed: Int, totalXP: Int, totalValidGuesses: Int, totalInvalidGuesses: Int, timeLimit: Int) {
        // MARK: Rush Game Protocol Values
        self.timeLimit = timeLimit
        
        // MARK: Base Protocol Values
        self.result = result
        self.difficulty = difficulty
        self.totalTimePlayed = totalTimePlayed
        self.totalXP = totalXP
        self.totalValidGuesses = totalValidGuesses
        self.totalInvalidGuesses = totalInvalidGuesses
    }
    
    init(model: GameOverModel) {
        // MARK: Rush Game Protocol Values
        self.timeLimit = model.timeLimit ?? 0
        
        // MARK: Base Protocol Values
        self.result = model.gameResult
        self.difficulty = model.gameDifficulty
        self.totalTimePlayed = model.timeElapsed
        self.totalXP = model.xp
        self.totalValidGuesses = model.numValidGuesses
        self.totalInvalidGuesses = model.numInvalidGuesses
    }
}
