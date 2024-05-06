import SwiftData

@Model
class StandardSaveModel: BaseSaveModel {
    // MARK: Standard Game Values
    var totalGamesWon: Int
    var bestGameScore: Int?
    
    // MARK: Protocol Values
    var totalGamesPlayed: Int
    var totalTimePlayed: Int
    var totalXP: Int
    var totalValidGuesses: Int
    var totalInvalidGuesses: Int
    var totalEasyDiff: Int
    var totalMediumDiff: Int
    var totalHardDiff: Int
    
    init(totalGamesWon: Int = 0, bestGameScore: Int, totalGamesPlayed: Int = 0, totalTimePlayed: Int = 0, totalXP: Int = 0, totalValidGuesses: Int = 0, totalInvalidGuesses: Int = 0, totalEasyDiff: Int = 0, totalMediumDiff: Int = 0, totalHardDiff: Int = 0) {
        // MARK: Standard Game Values
        self.totalGamesWon = totalGamesWon
        self.bestGameScore = bestGameScore
        
        // MARK: Protocol Values
        self.totalGamesPlayed = totalGamesPlayed
        self.totalTimePlayed = totalTimePlayed
        self.totalXP = totalXP
        self.totalValidGuesses = totalValidGuesses
        self.totalInvalidGuesses = totalInvalidGuesses
        self.totalEasyDiff = totalEasyDiff
        self.totalMediumDiff = totalMediumDiff
        self.totalHardDiff = totalHardDiff
    }
}
