import Foundation

class MainMenuVM: Transitions, GameModeSelectVMObserver {
    
    @Published var options: GameModeOptions
    
    var gameModeSelectVM: GameModeSelectVM
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, wordList: WordLists.fiveMedium)) {
        self.options = options
        self.gameModeSelectVM = GameModeSelectVM(options: options)
        
        super.init(activeView: .tabview)
        
        gameModeSelectVM.addObserver(observer: self)
    }
    
    func startGame(options: GameModeOptions) {
        self.options = options
    }
}
