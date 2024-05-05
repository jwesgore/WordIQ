struct StatsOverviewModel {
    var totalGames: String = ""
    var totalTime: String = ""
    var favMode: String = ""
    var favDiff: String = ""
}

struct StatsStandardModel {
    var totalGames: String = ""
    
    var numWins: String = ""
    var numLoses: String = ""
    var winRatio: String = ""
    
    var averageScore: String = ""
    
    var numValidGuesses: String = ""
    var numInvalidGuesses: String = ""
    
    var totalTime: String = ""
    var averageTime: String = ""
    
    var guessMap: [Int: Int] = [Int:Int]()
}

struct StatsRushModel {
    var totalGames: String = ""
    
    var numWins: String = ""
    var numLoses: String = ""
    var winRatio: String = ""
    
    var averageScore: String = ""
    
    var numValidGuesses: String = ""
    var numInvalidGuesses: String = ""
    
    var totalTime: String = ""
    var averageTime: String = ""
}
struct StatsFrenzyModel {
    var totalGames: String = ""
    
    var numWins: String = ""
    var numLoses: String = ""
    var winRatio: String = ""
    
    var averageScore: String = ""
    
    var numValidGuesses: String = ""
    var numInvalidGuesses: String = ""
    
    var totalTime: String = ""
    var averageTime: String = ""
}

struct StatsZenModel {
    var totalGames: String = ""
    
    var numWins: String = ""
    var numLoses: String = ""
    var winRatio: String = ""
    
    var averageScore: String = ""
    
    var numValidGuesses: String = ""
    var numInvalidGuesses: String = ""
    
    var totalTime: String = ""
    var averageTime: String = ""
}

struct DisplayData: Identifiable, Equatable {
    var id: String {label}
    
    var label: String
    var value: String
    
    var image: String?
}

struct ChartData: Identifiable, Equatable {
    var id: String {label}
    
    var label: String
    var value: Int
    
    var image: String?
}
