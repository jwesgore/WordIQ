import Foundation
import SwiftUI

class GameOverVM: ObservableObject {

    var observers: [GameOverVMObserver]
    
    init() {
        self.observers = [GameOverVMObserver]()
    }
    
    func addObserver(observer: GameOverVMObserver) {
        observers.append(observer)
    }
    
    func playAgain() {
        for observer in observers {
            observer.playAgain()
        }
    }
    
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
