import Foundation
import SwiftUI

class GameOverVM: ObservableObject {

    var observers: [GameOverVMObserver]
    @Published var contents: [[String: String]]
    @Published var result: String
    
    init() {
        self.observers = [GameOverVMObserver]()
        self.contents = [[String:String]]()
        self.result = ""
    }
    
    func addObserver(observer: GameOverVMObserver) {
        observers.append(observer)
    }
    
    /// Add data for view
    /// Result
    func addResult(result: String) {
        self.result = result
    }
    
    /// Add data for view
    /// Stats
    func addContentsRow(row: [String:String]) {
        contents.append(row)
    }
    
    /// Reset all data in view
    func reset() {
        result = ""
        contents = [[String:String]]()
    }
    
    /// Observer Function
    /// Used for Play Again button
    func playAgain() {
        for observer in observers {
            observer.playAgain()
        }
    }
    
    /// Observer Function
    /// Used for the Main Menu button
    func mainMenu() {
        for observer in observers {
            observer.mainMenu()
        }
    }
}

protocol GameOverVMObserver {
    func playAgain()
    func mainMenu()
}
