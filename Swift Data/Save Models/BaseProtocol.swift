import SwiftData

protocol BaseSaveDataModelProtocol {
    var totalTimePlayed: Int { get set }
    var totalXP: Int { get set }
    var totalValidGuesses: Int { get set }
    var totalInvalidGuesses: Int { get set }
    var difficulty: GameDifficulty { get set }
    var result: GameOverResult { get set }
}
