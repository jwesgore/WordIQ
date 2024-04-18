import Foundation
import SwiftUI

class TimerVM: ObservableObject {
    
    @Published var timeTotal: Int
    @Published var currentTime: Int
    @Published var timeElapsed: Int
    @Published var currentTimeFormatted: String
    
    var countUp = false
    var active = false
    var observers: [TimerVMObserver]
    
    private var timer: Timer?
    
    init(_ timeTotal: Int = 0) {
        self.timeTotal = timeTotal
        self.currentTime = timeTotal
        self.timeElapsed = 0
        self.observers = [TimerVMObserver]()
        
        let minutes = timeTotal / 60
        let remainingSeconds = timeTotal % 60
        self.currentTimeFormatted = String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    func addObserver(observer: TimerVMObserver) {
        observers.append(observer)
    }
    
    /// set time values after init
    func postInitSetTotalTime(time: Int) {
        self.timeTotal = time
        self.currentTime = time
        self.currentTimeFormatted = timeToString()
    }
    
    /// Notify subcribers to Time Observer
    func timeOver() {
        for observer in observers {
            observer.timeOver()
        }
    }
    
    /// Add some amount of time onto the current time
    func addTime(_ seconds: Int) {
        currentTime += seconds
    }
    
    /// Converts the current time to a string representation
    func timeToString(_ time: Int = -1) -> String {
        var time = time
        
        if time == -1 {
            time = countUp ? timeElapsed : currentTime
        }
        
        let minutes = time / 60
        let remainingSeconds = time % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    /// Resets the timer to the initial value
    func resetTimer() {
        currentTime = timeTotal
        timeElapsed = 0
        currentTimeFormatted = timeToString()
    }
    
    /// Starts a timer that countd down from the timeTotal unless up=true
    func startTimer() {
        active = true
        
        if countUp {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.timeElapsed += 1
                self.currentTimeFormatted = self.timeToString()
            }
            return
        }
  
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.currentTime <= 0 {
                self.stopTimer()
                self.timeOver()
            } else {
                self.currentTime -= 1
                self.timeElapsed += 1
                self.currentTimeFormatted = self.timeToString()
            }
        }
    }
    
    /// Stops the timer from running
    func stopTimer() {
        active = false
        timer?.invalidate()
    }
}

protocol TimerVMObserver {
    func timeOver()
}
