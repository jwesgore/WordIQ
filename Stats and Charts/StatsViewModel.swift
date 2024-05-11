import Foundation
import SwiftData

class StatsVM: ObservableObject {
    @Published var overviewStats: OverviewStats
    @Published var standardStats: StandardStats
    @Published var rushStats: RushStats
    @Published var frenzyStats: FrenzyStats
    @Published var zenStats: ZenStats
    
    init() {
        self.overviewStats = OverviewStats(favMode: (.null, 0.0), favDifficulty: (.null, 0.0), totalGamesPlayed: 0, totalTimePlayed: 0, modeDistribution: [GameMode.standardgame.value: 0, GameMode.rushgame.value: 0, GameMode.frenzygame.value: 0, GameMode.zengame.value: 0], difficultyDistribution: [GameDifficulty.easy.value: 0, GameDifficulty.normal.value: 0, GameDifficulty.hard.value: 0])
        self.standardStats = StandardStats(totalGamesWon: 0, totalGamesPlayed: 0, totalTimePlayed: 0, totalXP: 0, totalValidGuesses: 0, totalInvalidGuesses: 0, totalEasyDiff: 0, totalMediumDiff: 0, totalHardDiff: 0, guessCounts: [])
        self.rushStats = RushStats(totalGamesWon: 0, totalGamesPlayed: 0, totalTimePlayed: 0, totalXP: 0, totalValidGuesses: 0, totalInvalidGuesses: 0, totalEasyDiff: 0, totalMediumDiff: 0, totalHardDiff: 0, guessCounts: [])
        self.frenzyStats = FrenzyStats(totalGamesWon: 0, totalGamesPlayed: 0, totalTimePlayed: 0, totalXP: 0, totalValidGuesses: 0, totalInvalidGuesses: 0, totalEasyDiff: 0, totalMediumDiff: 0, totalHardDiff: 0, guessCounts: [])
        self.zenStats = ZenStats(totalGamesWon: 0, totalGamesPlayed: 0, totalTimePlayed: 0, totalXP: 0, totalValidGuesses: 0, totalInvalidGuesses: 0, totalEasyDiff: 0, totalMediumDiff: 0, totalHardDiff: 0, guessCounts: [])
    }
    
    func updateOverviewStats() {
        let totalGamesPlayed = standardStats.totalGamesPlayed + rushStats.totalGamesPlayed + frenzyStats.totalGamesPlayed + zenStats.totalGamesPlayed
        let totalTimePlayed = standardStats.totalTimePlayed + rushStats.totalTimePlayed + frenzyStats.totalTimePlayed + zenStats.totalTimePlayed
        let modeDistribution = [GameMode.standardgame.value: standardStats.totalGamesPlayed, GameMode.rushgame.value: rushStats.totalGamesPlayed, GameMode.frenzygame.value: frenzyStats.totalGamesPlayed, GameMode.zengame.value: zenStats.totalGamesPlayed]
        let difficultyDistribution = self.getDifficultyDistribution()
        let favMode = self.getFavMode(totalGamesPlayed)
        let favDifficulty = self.getFavDifficulty(totalGamesPlayed)
        
        self.overviewStats = OverviewStats(favMode: favMode, favDifficulty: favDifficulty, totalGamesPlayed: totalGamesPlayed, totalTimePlayed: totalTimePlayed, modeDistribution: modeDistribution, difficultyDistribution: difficultyDistribution)
    }
    
    func updateStandardStats(models: [StandardSaveModel]) {
        let totalGamesPlayed = models.count
        
        var totalGamesWon = 0
        var totalTimePlayed = 0
        var totalXP = 0
        var totalValidGuesses = 0
        var totalInvalidGuesses = 0
        var totalEasyDiff = 0
        var totalMediumDiff = 0
        var totalHardDiff = 0
        var guessCounts = [Int]()
        
        for model in models {
            totalGamesWon += model.result == .win ? 1 : 0
            totalTimePlayed += model.totalTimePlayed
            totalXP += model.totalXP
            totalValidGuesses += model.totalValidGuesses
            totalInvalidGuesses += model.totalInvalidGuesses
            
            switch model.difficulty {
            case .easy: totalEasyDiff += 1
            case .normal: totalMediumDiff += 1
            case .hard: totalHardDiff += 1
            case .null: continue
            }
            
            guessCounts.append(model.totalValidGuesses)
        }
        
        self.standardStats = StandardStats(totalGamesWon: totalGamesWon, totalGamesPlayed: totalGamesPlayed, totalTimePlayed: totalTimePlayed, totalXP: totalXP, totalValidGuesses: totalValidGuesses, totalInvalidGuesses: totalInvalidGuesses, totalEasyDiff: totalEasyDiff, totalMediumDiff: totalMediumDiff, totalHardDiff: totalHardDiff, guessCounts: guessCounts)
    }
    
    func updateRushStats(models: [RushSaveModel]) {
        let totalGamesPlayed = models.count
        
        var totalGamesWon = 0
        var totalTimePlayed = 0
        var totalXP = 0
        var totalValidGuesses = 0
        var totalInvalidGuesses = 0
        var totalEasyDiff = 0
        var totalMediumDiff = 0
        var totalHardDiff = 0
        var guessCounts = [Int]()
        
        for model in models {
            totalGamesWon += model.result == .win ? 1 : 0
            totalTimePlayed += model.totalTimePlayed
            totalXP += model.totalXP
            totalValidGuesses += model.totalValidGuesses
            totalInvalidGuesses += model.totalInvalidGuesses
            
            switch model.difficulty {
            case .easy: totalEasyDiff += 1
            case .normal: totalMediumDiff += 1
            case .hard: totalHardDiff += 1
            case .null: continue
            }
            
            guessCounts.append(model.totalValidGuesses)
        }
        
        self.rushStats = RushStats(totalGamesWon: totalGamesWon, totalGamesPlayed: totalGamesPlayed, totalTimePlayed: totalTimePlayed, totalXP: totalXP, totalValidGuesses: totalValidGuesses, totalInvalidGuesses: totalInvalidGuesses, totalEasyDiff: totalEasyDiff, totalMediumDiff: totalMediumDiff, totalHardDiff: totalHardDiff, guessCounts: guessCounts)
    }
    
    func updateFrenzyStats(models: [FrenzySaveModel]) {
        let totalGamesPlayed = models.count
        
        var totalGamesWon = 0
        var totalTimePlayed = 0
        var totalXP = 0
        var totalValidGuesses = 0
        var totalInvalidGuesses = 0
        var totalEasyDiff = 0
        var totalMediumDiff = 0
        var totalHardDiff = 0
        var guessCounts = [Int]()
        
        for model in models {
            totalGamesWon += model.result == .win ? 1 : 0
            totalTimePlayed += model.totalTimePlayed
            totalXP += model.totalXP
            totalValidGuesses += model.totalValidGuesses
            totalInvalidGuesses += model.totalInvalidGuesses
            
            switch model.difficulty {
            case .easy: totalEasyDiff += 1
            case .normal: totalMediumDiff += 1
            case .hard: totalHardDiff += 1
            case .null: continue
            }
            
            guessCounts.append(model.totalValidGuesses)
        }
        
        self.frenzyStats = FrenzyStats(totalGamesWon: totalGamesWon, totalGamesPlayed: totalGamesPlayed, totalTimePlayed: totalTimePlayed, totalXP: totalXP, totalValidGuesses: totalValidGuesses, totalInvalidGuesses: totalInvalidGuesses, totalEasyDiff: totalEasyDiff, totalMediumDiff: totalMediumDiff, totalHardDiff: totalHardDiff, guessCounts: guessCounts)
    }
    
    func updateZenStats(models: [ZenSaveModel]) {
        let totalGamesPlayed = models.count
        
        var totalGamesWon = 0
        var totalTimePlayed = 0
        var totalXP = 0
        var totalValidGuesses = 0
        var totalInvalidGuesses = 0
        var totalEasyDiff = 0
        var totalMediumDiff = 0
        var totalHardDiff = 0
        var guessCounts = [Int]()
        
        for model in models {
            totalGamesWon += model.result == .win ? 1 : 0
            totalTimePlayed += model.totalTimePlayed
            totalXP += model.totalXP
            totalValidGuesses += model.totalValidGuesses
            totalInvalidGuesses += model.totalInvalidGuesses
            
            switch model.difficulty {
            case .easy: totalEasyDiff += 1
            case .normal: totalMediumDiff += 1
            case .hard: totalHardDiff += 1
            case .null: continue
            }
            
            guessCounts.append(model.totalValidGuesses)
        }
        
        self.zenStats = ZenStats(totalGamesWon: totalGamesWon, totalGamesPlayed: totalGamesPlayed, totalTimePlayed: totalTimePlayed, totalXP: totalXP, totalValidGuesses: totalValidGuesses, totalInvalidGuesses: totalInvalidGuesses, totalEasyDiff: totalEasyDiff, totalMediumDiff: totalMediumDiff, totalHardDiff: totalHardDiff, guessCounts: guessCounts)
    }
    
    // MARK: Private Functions
    private func getFavMode(_ totalGamesPlayed: Int) -> (GameMode, Double) {
        guard totalGamesPlayed != 0 else {return (GameMode.standardgame, 0.0)}
        
        var favMode: GameMode
        var favModePercent: Double
        
        if standardStats.totalGamesPlayed >= max(rushStats.totalGamesPlayed, frenzyStats.totalGamesPlayed, zenStats.totalGamesPlayed) {
            favMode = .standardgame
            favModePercent = Double(standardStats.totalGamesPlayed) / Double(totalGamesPlayed)
        } else if rushStats.totalGamesPlayed >= max(frenzyStats.totalGamesPlayed, zenStats.totalGamesPlayed) {
            favMode = .rushgame
           favModePercent = Double(rushStats.totalGamesPlayed) / Double(totalGamesPlayed)
        } else if frenzyStats.totalGamesPlayed >= zenStats.totalGamesPlayed {
            favMode = .frenzygame
            favModePercent = Double(frenzyStats.totalGamesPlayed) / Double(totalGamesPlayed)
        } else {
            favMode = .zengame
            favModePercent = Double(zenStats.totalGamesPlayed) / Double(totalGamesPlayed)
        }
        
        return (favMode, favModePercent)
    }
    
    private func getDifficultyDistribution() -> [String:Int]{
        let totalEasy = standardStats.totalEasyDiff + rushStats.totalEasyDiff + frenzyStats.totalEasyDiff + zenStats.totalEasyDiff
        let totalMedium = standardStats.totalMediumDiff + rushStats.totalMediumDiff + frenzyStats.totalMediumDiff + zenStats.totalMediumDiff
        let totalHard = standardStats.totalHardDiff + rushStats.totalHardDiff + frenzyStats.totalHardDiff + zenStats.totalHardDiff
        
        return [GameDifficulty.easy.value: totalEasy, GameDifficulty.normal.value: totalMedium, GameDifficulty.hard.value: totalHard]
    }
    
    private func getFavDifficulty(_ totalGamesPlayed: Int) -> (GameDifficulty, Double) {
        guard totalGamesPlayed != 0 else {return (GameDifficulty.easy, 0.0)}
        
        var favDifficulty: GameDifficulty
        var favDifficultyPercent: Double
        
        let totalEasy = standardStats.totalEasyDiff + rushStats.totalEasyDiff + frenzyStats.totalEasyDiff + zenStats.totalEasyDiff
        let totalMedium = standardStats.totalMediumDiff + rushStats.totalMediumDiff + frenzyStats.totalMediumDiff + zenStats.totalMediumDiff
        let totalHard = standardStats.totalHardDiff + rushStats.totalHardDiff + frenzyStats.totalHardDiff + zenStats.totalHardDiff
        
        if totalEasy >= max(totalMedium, totalHard) {
            favDifficulty = .easy
            favDifficultyPercent = Double(totalEasy) / Double(totalGamesPlayed)
        }
        else if totalMedium >= totalHard {
            favDifficulty = .normal
            favDifficultyPercent = Double(totalMedium) / Double(totalGamesPlayed)
        }
        else {
            favDifficulty = .hard
            favDifficultyPercent = Double(totalHard) / Double(totalGamesPlayed)
        }
        
        return (favDifficulty, favDifficultyPercent)
    }
}
