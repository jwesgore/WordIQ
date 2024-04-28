import Foundation
import SwiftUI

class TimerVM: ObservableObject {
    
    @Published var timeRemaining: Int
    @Published var timeElapsed: Int
    @Published var currentTimeFormatted: String
    
    private(set) var timeLimit: Int
    
    var countUp = false
    var active = false
    var observers: [TimerVMObserver]
    
    private var timer: Timer?
    
    init(_ timeTotal: Int = 0) {
        self.timeLimit = timeTotal
        self.timeRemaining = timeTotal
        self.timeElapsed = 0
        self.observers = [TimerVMObserver]()
        
        let minutes = timeTotal / 60
        let remainingSeconds = timeTotal % 60
        self.currentTimeFormatted = String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    /// set time values after init
    func postInitSetTotalTime(time: Int) {
        self.timeLimit = time
        self.timeRemaining = time
        self.currentTimeFormatted = timeToString(countUp ? self.timeElapsed : self.timeRemaining)
    }
    
    
    /// Add some amount of time onto the current time
    func addTime(_ seconds: Int) {
        timeRemaining += seconds
    }
    
    /// Converts the current time to a string representation
    func timeToString(_ time: Int) -> String {
        let minutes = time / 60
        let remainingSeconds = time % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    static func timeToString(_ time: Int = -1) -> String {
        let minutes = time / 60
        let remainingSeconds = time % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    // MARK: Operate timer functions
    /// Resets the timer to the initial value
    func resetTimer() {
        self.timeRemaining = timeLimit
        self.timeElapsed = 0
        self.currentTimeFormatted = self.timeToString(countUp ? self.timeElapsed : self.timeRemaining)
    }
    
    /// Starts a timer that countd down from the timeTotal unless up=true
    func startTimer() {
        active = true
        
        if countUp {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.timeElapsed += 1
                self.currentTimeFormatted = self.timeToString(self.timeElapsed)
            }
            return
        }
  
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining <= 0 {
                self.stopTimer()
                self.timeOver()
            } else {
                self.timeRemaining -= 1
                self.timeElapsed += 1
                self.currentTimeFormatted = self.timeToString(self.timeRemaining)
            }
        }
    }
    
    /// Stops the timer from running
    func stopTimer() {
        active = false
        timer?.invalidate()
    }
    
    // MARK: Observer Functions
    func addObserver(observer: TimerVMObserver) {
        observers.append(observer)
    }
    
    /// Notify subcribers to Time Observer
    func timeOver() {
        for observer in observers {
            observer.timeOver()
        }
    }
}

protocol TimerVMObserver {
    func timeOver()
}
