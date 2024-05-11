struct StandardStats: StandardStatsProtocol {
    // MARK: Protocol Values
    var totalGamesWon: Int
    var bestGameScore: Int?
    var totalGamesPlayed: Int
    var totalTimePlayed: Int
    var totalXP: Int
    var totalValidGuesses: Int
    var totalInvalidGuesses: Int
    var totalEasyDiff: Int
    var totalMediumDiff: Int
    var totalHardDiff: Int
    var guessCounts: [Int]
    
    // MARK: Computed Values
    var winRatio: Double {
        guard totalGamesPlayed != 0 else { return 0.0 }
        return Double(self.totalGamesWon) / Double(self.totalGamesPlayed - self.totalGamesWon)
    }
    
    var averageTimePerMatch: Int {
        guard totalGamesPlayed != 0 else { return 0 }
        return self.totalTimePlayed / self.totalGamesPlayed
    }
    
    var averageXPPerMatch: Int {
        guard totalGamesPlayed != 0 else { return 0 }
        return self.totalXP / self.totalGamesPlayed
    }
    
    var favoriteDifficulty: GameDifficulty {
        if self.totalEasyDiff >= max(self.totalMediumDiff, self.totalHardDiff) { return GameDifficulty.easy }
        else if self.totalMediumDiff >= self.totalHardDiff { return GameDifficulty.normal }
        else { return GameDifficulty.hard }
    }
    
    var guessDistribution: [Int: Int] {
        guard guessCounts.count > 0 else { return [1:0,2:0,3:0,4:0,5:0,6:0] }
        let mappedItems = self.guessCounts.map { ($0, 1) }
        return Dictionary(mappedItems, uniquingKeysWith: +)
    }
}

protocol StandardStatsProtocol: BaseStatsProtocol {
    var totalGamesWon: Int { get set }
    var bestGameScore: Int? { get set }
}
