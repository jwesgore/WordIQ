import Foundation
import SwiftUI

class GameSelectVM: ObservableObject {
    
    @Published var options: GameModeOptions
    @Published var offset: CGFloat
    var offsetAmount: CGFloat
    var activeView: ActiveView
    
    var observers: [GameSelectVMObserver]
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, timeLimit: 0, wordList: WordLists.fiveMedium)) {
        self.options = options
        
        self.offset = 0.0
        self.offsetAmount = 2000.0
        self.activeView = .empty
        self.observers = [GameSelectVMObserver]()
    }
    
    /// send the view to the game mode options
    func gotoOptions(_ targetView: ActiveView) {
        self.activeView = targetView
        withAnimation (.easeInOut(duration: 0.5)) {
            self.offset = 0 - self.offsetAmount
        }
    }
    
    /// send the view back to the game mode selection
    func gotoModes() {
        self.activeView = .empty
        withAnimation (.easeInOut(duration: 0.5)) {
            self.offset = 0.0
        }
    }
    
    /// set the time in the options
    func setTime(time: Int) {
        options.timeLimit = time
    }
    
    /// set the word list in the options
    func setList(wordList: String) {
        options.wordList = wordList
    }
    
    /// Observer Functions
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
