/// enums relating to game settings

enum GameMode: String, Codable {
    case standardgame
    case rushgame
    case frenzygame
    case zengame
    case null
}

enum GameDifficulty: String, Codable {
    case easy
    case normal
    case hard
    case null
}

enum GameOverResult: String, Codable {
    case win
    case lose
    case gameover
    case null
}
