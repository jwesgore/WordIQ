/// An enum holding common system strings

enum SystemNames {
    enum Title {
        static let title = "WordIQ"
        static let caption = "Fun. Lightweight. Offline."
    }
    
    // MARK: Game Modes
    enum GameModes {
        static let standard = "Standard"
        static let rush = "Rush"
        static let frenzy = "Frenzy"
        static let zen = "Zen"
        
        static let daily = "Daily"
        static let quickplay = "Quickplay"
        
        static let standardMode = "Standard Mode"
        static let rushMode = "Rush Mode"
        static let frenzyMode = "Frenzy Mode"
        static let zenMode = "Zen Mode"
    }
    
    // MARK: Game Over
    static let mainMenu = "Main Menu"
    static let playAgain = "Play Again"
    
    // MARK: Tabview icons
    static let game = "Game"
    static let friends = "Friends"
    static let stats = "Stats"
    
    // MARK: Misc
    static let startGame = "Start Game"
    static let back = "Back"
}

enum WordLists {
    static let fiveEasy = "five_letter_words_easy"
    static let fiveMedium = "five_letter_words_medium"
    static let fiveHard = "five_letter_words_hard"
}
