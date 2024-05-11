/// enums relating to game settings

enum GameMode: String, Codable {
    case standardgame
    case rushgame
    case frenzygame
    case zengame
    case null
    
    var value: String {
        switch self {
        case .standardgame: return "Standard"
        case .rushgame: return "Rush"
        case .frenzygame: return "Frenzy"
        case .zengame: return "Zen"
        default: return ""
        }
    }
}

enum GameDifficulty: String, Codable {
    case easy
    case normal
    case hard
    case null
    
    var value: String {
        switch self {
        case .easy: return "Easy"
        case .normal: return "Normal"
        case .hard: return "Hard"
        default: return ""
        }
    }
}

enum GameOverResult: String, Codable {
    case win
    case lose
    case gameover
    case null
}
