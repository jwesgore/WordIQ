import Foundation
import SwiftData

class StatsVM: ObservableObject {
  
    @Published var items: [GameData] = [GameData]()
    @Published var selected: StatsFilter = .overall
    
    @Published var totalGames: String
    @Published var totalTime: String
    @Published var averageTime: String
    
    init() {
        self.totalTime = "--:--"
        self.averageTime = "--:--"
        self.totalGames = "--"
    }
    
    func loadValues() {
        var times = self.items.map { $0.timeElapsed }
        
        self.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        self.averageTime = TimerVM.timeToString(self.getAverage(values: times))
        self.totalGames = self.items.count.formatted()
    }
    
    func getTotal(values: [Int]) -> Int {
        return values.reduce(0, +)
    }
    
    func getAverage(values: [Int]) -> Int {
        guard !values.isEmpty else {return 0}
        return values.reduce(0, +) / values.count
    }
}
