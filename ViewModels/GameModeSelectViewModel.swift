import Foundation

class GameModeSelectVM: ObservableObject {
    @Published var options: GameModeOptions
    var observers: [GameModeSelectVMObserver]
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, wordList: WordLists.fiveMedium)) {
        self.options = options
        
        self.observers = [GameModeSelectVMObserver]()
    }
    
    func addObserver(observer: GameModeSelectVMObserver) {
        observers.append(observer)
    }
    
    func startGame() {
        for observer in observers {
            observer.startGame(options: options)
        }
    }
}

protocol GameModeSelectVMObserver {
    func startGame(options: GameModeOptions)
}
