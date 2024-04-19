import Foundation

class GameSelectVM: ObservableObject {
    @Published var options: GameModeOptions
    var observers: [GameSelectVMObserver]
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, wordList: WordLists.fiveMedium)) {
        self.options = options
        
        self.observers = [GameSelectVMObserver]()
    }
    
    func addObserver(observer: GameSelectVMObserver) {
        observers.append(observer)
    }
    
    func startGame(_ mode: ActiveView) {
        options.selectedMode = mode
        for observer in observers {
            observer.startGame(options: options)
        }
    }
}

protocol GameSelectVMObserver {
    func startGame(options: GameModeOptions)
}
