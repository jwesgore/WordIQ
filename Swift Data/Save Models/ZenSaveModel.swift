import SwiftData

@Model
class ZenSaveModel: BaseSaveDataModelProtocol {
    
    // MARK: Standard Game Values
    
    // MARK: Base Protocol Values
    var totalTimePlayed: Int
    var totalXP: Int
    var totalValidGuesses: Int
    var totalInvalidGuesses: Int
    var difficulty: GameDifficulty
    var result: GameOverResult
    
    init(result: GameOverResult, difficulty: GameDifficulty, totalTimePlayed: Int = 0, totalXP: Int = 0, totalValidGuesses: Int = 0, totalInvalidGuesses: Int = 0) {
        // MARK: Standard Game Protocol Values
        
        // MARK: Base Protocol Values
        self.result = result
        self.difficulty = difficulty
        self.totalTimePlayed = totalTimePlayed
        self.totalXP = totalXP
        self.totalValidGuesses = totalValidGuesses
        self.totalInvalidGuesses = totalInvalidGuesses
    }
    
    init(model: GameOverModel) {
        // MARK: Standard Game Protocol Values
        
        // MARK: Base Protocol Values
        self.result = model.gameResult
        self.difficulty = model.gameDifficulty
        self.totalTimePlayed = model.timeElapsed
        self.totalXP = model.xp
        self.totalValidGuesses = model.numValidGuesses
        self.totalInvalidGuesses = model.numInvalidGuesses
    }
}
