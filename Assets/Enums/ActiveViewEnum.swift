enum ActiveView {
    case tabview
    case gameover
    case empty
    case standardgame
    case rushgame
    case frenzygame
    case zengame
    case pause
    
    var toGameMode: GameMode {
        switch self {
        case .standardgame: return .standardgame
        case .rushgame: return .rushgame
        case .frenzygame: return .frenzygame
        case .zengame: return .zengame
        default: return .null
        }
    }
}
