/// An enum holding common system strings

enum SystemNames {
    static let title = "Word Game"
    
    // MARK: Game Modes
    static let standard = "Standard"
    static let rush = "Rush"
    static let frenzy = "Frenzy"
    static let zen = "Zen"
    
    static let standardMode = "Standard Mode"
    static let rushMode = "Rush Mode"
    static let frenzyMode = "Frenzy Mode"
    static let zenMode = "Zen Mode"
    
    // MARK: Tabview icons
    static let game = "Game"
    static let friends = "Friends"
    static let stats = "Stats"
    
    // MARK: Misc
    static let startGame = "Start Game"
    static let back = "Back"
}

enum Descriptions {
    static let standardMode = "The classic game you know and love. Six guesses to get the word."
    static let rushMode = "Make as many guesses as you want, but you only have so much time."
    static let frenzyMode = "Only six guesses and a time limit. How many words can you get?"
    static let zenMode = "No time limit, no guess limit. Just play to have fun."
}

enum WordLists {
    static let fiveEasy = "five_letter_words_easy"
    static let fiveMedium = "five_letter_words_medium"
    static let fiveHard = "five_letter_words_hard"
}
