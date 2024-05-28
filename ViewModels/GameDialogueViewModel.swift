import SwiftUI

class PauseVM: ObservableObject, PauseMenuFunctions {
    
    @Published var backActive: Bool
    @Published var quitActive: Bool
    
    var pauseFunction: () -> Void
    var quitFunction: () -> Void
    var backFunction: () -> Void
    
    init() {
        self.backActive = true
        self.quitActive = true
        
        self.pauseFunction = {}
        self.quitFunction  = {}
        self.backFunction = {}
    }
    
    func pause() {
        self.pauseFunction()
    }
    
    func quitGame() {
        guard quitActive else { return }
        self.quitActive = false
        self.quitFunction()
    }
    
    func back() {
        guard backActive else { return }
        self.backFunction()
    }
}
