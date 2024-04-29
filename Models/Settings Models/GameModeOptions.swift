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
    let easy = "Easy"
    let medium = "Normal"
    let hard = "Hard"
    
    let easyDescription = "We got rid of all those annoying words with duplicate letters."
    let mediumDescription = "The standard experience, you won't be finding any words in here that feel made up."
    let hardDescription = "All 15000+ valid words are up for grabs."
    
    let rushModeTimes: [String: Int] = ["0:30": 30, "1:00" : 60, "1:30": 90]
    let frenzyModeTimes: [String: Int] = ["1:00": 60, "1:30": 90, "2:30": 150]
}
