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
}

protocol GameOverVMObserver {
    func playAgain()
}
