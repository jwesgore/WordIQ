/// Enum to help filter values on the stats page

enum StatsFilter: String, CaseIterable {
    case overall
    case standard
    case rush
    case frenzy
    case zen
}

enum StatsItemLabel {

    static let totalGames = "Total Games"
    static let totalTime = "Total Time"
    
    static let favoriteMode = "Favorite Mode"
    static let favoriteDiff = "Favorite Difficulty"
    
    static let averageScore = "Avg. Score"
    static let averageTimeElapsed = "Avg. Time Elapsed"
    
}
