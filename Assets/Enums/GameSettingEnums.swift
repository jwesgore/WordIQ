/// enums relating to game settings

enum GameMode: Codable {
    case standardgame
    case rushgame
    case frenzygame
    case zengame
    case empty
}

enum GameDifficulty: Codable {
    case easy
    case normal
    case hard
}

enum GameOverResult: Codable {
    case win
    case lose
    case gameover
}
