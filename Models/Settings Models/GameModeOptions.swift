import Foundation

struct GameModeOptions {
    var wordLength: Int
    var boardSize: Int
    
    var timeLimit: Int
    
    var wordList: String
    var gameDifficulty: GameDifficulty = .null
    var selectedMode: ActiveView = ActiveView.empty
}

struct GameModeOptionsSelect {
    let easy: DifficultyParams = DifficultyParams(label: "Easy", description: "We got rid of all those annoying words with duplicate letters.", list: WordLists.fiveEasy)
    let medium: DifficultyParams = DifficultyParams(label: "Normal", description: "The standard experience, you won't be finding any words in here that feel made up.", list: WordLists.fiveMedium)
    let hard: DifficultyParams = DifficultyParams(label: "Hard", description: "All 15000+ valid words are up for grabs.", list: WordLists.fiveHard)
    
    let rushModeTimes: [String: Int] = ["0:30": 30, "1:00" : 60, "1:30": 90]
    let frenzyModeTimes: [String: Int] = ["1:00": 60, "1:30": 90, "2:30": 150]
}

struct DifficultyParams {
    let label: String
    let description: String
    let list: String
}
