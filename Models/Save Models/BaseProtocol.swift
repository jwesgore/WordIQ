import SwiftData

protocol BaseSaveModel {
    var totalGamesPlayed: Int { get set }
    var totalTimePlayed: Int { get set }
    var totalXP: Int { get set }
    var totalValidGuesses: Int { get set }
    var totalInvalidGuesses: Int { get set }
    
    var totalEasyDiff: Int { get set }
    var totalMediumDiff: Int { get set }
    var totalHardDiff: Int { get set }
}
