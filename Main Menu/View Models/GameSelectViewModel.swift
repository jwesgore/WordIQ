import Foundation
import SwiftUI

class GameSelectVM: ObservableObject {
    
    @Published var options: GameModeOptions
    @Published var offset: CGFloat
    
    var offsetAmount: CGFloat
    var activeView: ActiveView
    
    let gameOptionsSelect: GameModeOptionsSelect
    
    var observers: [GameSelectVMObserver]
    
    init(options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, timeLimit: 0, wordList: WordLists.fiveMedium)) {
        self.options = options
        self.gameOptionsSelect = GameModeOptionsSelect()
        
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
    
    func quickplay(_ targetView: ActiveView) {
        options.gameDifficulty = .normal
        options.wordList = WordLists.fiveMedium
        
        switch targetView {
        case .standardgame:
            options.selectedMode = .standardgame
        case .rushgame:
            options.selectedMode = .rushgame
            options.timeLimit = 60
        case .frenzygame:
            options.selectedMode = .frenzygame
            options.timeLimit = 90
        case .zengame:
            options.selectedMode = .zengame
        default:
            return
        }
        
        self.startGame(targetView)
    }
    
    /// send the view back to the game mode selection
    func gotoModes() {
        withAnimation (.easeInOut(duration: 0.5)) {
            self.offset = 0.0
        }
    }
    
    /// set the time in the options
    func setTime(time: Int) {
        options.timeLimit = time
    }
    
    /// set the word list in the options
    func setDifficulty(wordList: String, difficulty: GameDifficulty) {
        options.gameDifficulty = difficulty
        options.wordList = wordList
    }
    
    /// Observer Functions
    func addObserver(observer: GameSelectVMObserver) {
       observers.append(observer)
    }
    
    func startGame(_ mode: ActiveView) {
        self.options.selectedMode = mode
        for observer in observers {
            observer.startGame(options: options)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { self.gotoModes() })
    }
}

protocol GameSelectVMObserver {
    func startGame(options: GameModeOptions)
}
