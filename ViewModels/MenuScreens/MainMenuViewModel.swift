import Foundation

class MainMenuVM: Transitions, GameSelectVMObserver {
    
    @Published var options: GameModeOptions
    
    var gameSelectVM: GameSelectVM
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, timeLimit: 0, wordList: WordLists.fiveMedium)) {
        self.options = options
        self.gameSelectVM = GameSelectVM(options: options)
        
        super.init(activeView: .tabview)
        
        gameSelectVM.addObserver(observer: self)
    }
    
    func startGame(options: GameModeOptions) {
        self.options = options
        
        super.fadeToWhite(targetView: options.selectedMode)
    }
}
