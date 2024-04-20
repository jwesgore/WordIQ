import Foundation

struct GameModeOptions {
    var wordLength: Int
    var boardSize: Int
    
    var timeLimit: Int
    
    var wordList: String
    var selectedMode: ActiveView = ActiveView.empty
}
