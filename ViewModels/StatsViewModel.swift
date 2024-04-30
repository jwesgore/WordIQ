import Foundation
import SwiftData

class StatsVM: ObservableObject {
  
    @Published var items: [GameData] = [GameData]()
    @Published var selected: StatsFilter = .overall
    
    @Published var overviewItems: StatsOverviewModel = StatsOverviewModel()
    @Published var standardItems: StatsStandardModel = StatsStandardModel()
    @Published var rushItems: StatsRushModel = StatsRushModel()
    @Published var frenzyItems: StatsFrenzyModel = StatsFrenzyModel()
    @Published var zenItems: StatsZenModel = StatsZenModel()
    
    var standardGames = [GameData]()
    var rushGames = [GameData]()
    var frenzyGames = [GameData]()
    var zenGames = [GameData]()
    
    init() {
    }
    
    // MARK: Load Values
    func loadValues() {
        self.loadCollections()
        
        self.loadOverviewItems()
        self.loadStandardItems(modeItems: self.standardGames)
        self.loadRushItems(modeItems: self.rushGames)
        self.loadFrenzyItems(modeItems: self.frenzyGames)
        self.loadZenItems(modeItems: self.zenGames)

    }
    
    private func loadCollections() {
        for item in items {
            switch item.gameMode {
            case GameMode.standardgame.rawValue: standardGames.append(item)
            case GameMode.rushgame.rawValue: rushGames.append(item)
            case GameMode.frenzygame.rawValue: frenzyGames.append(item)
            case GameMode.zengame.rawValue: zenGames.append(item)
            default: continue
            }
        }
    }
    
    private func loadOverviewItems() {
        // get total time spent playing game
        let times = self.items.map { $0.timeElapsed }
        self.overviewItems.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        
        self.overviewItems.totalGames = self.items.count.formatted()
        
        // get favorite mode and difficulty
        self.overviewItems.favMode = self.getFavMode()
        self.overviewItems.favDiff = self.getFavDiff(modeItems: self.items)
        
    }
    
    private func loadStandardItems(modeItems: [GameData]) {
        let times = modeItems.map { $0.timeElapsed }
        self.standardItems.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        self.standardItems.averageTime = TimerVM.timeToString(self.getAverage(values: times))
        
        self.standardItems.totalGames = self.standardGames.count.formatted()
        self.standardItems.averageScore = self.getAverage(values: modeItems.map{ $0.numValidGuesses }).formatted()
    }
    
    private func loadRushItems(modeItems: [GameData]) {
        let times = modeItems.map { $0.timeElapsed }
        self.rushItems.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        self.rushItems.averageTime = TimerVM.timeToString(self.getAverage(values: times))
        
        self.rushItems.totalGames = self.rushGames.count.formatted()
        self.rushItems.averageScore = self.getAverage(values: modeItems.map{ $0.numValidGuesses }).formatted()
    }
    
    private func loadFrenzyItems(modeItems: [GameData]) {
        let times = modeItems.map { $0.timeElapsed }
        self.frenzyItems.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        self.frenzyItems.averageTime = TimerVM.timeToString(self.getAverage(values: times))
        
        self.frenzyItems.totalGames = self.frenzyGames.count.formatted()
        self.frenzyItems.averageScore = self.getAverage(values: modeItems.map{ $0.numValidGuesses }).formatted()
    }
    
    private func loadZenItems(modeItems: [GameData]) {
        let times = modeItems.map { $0.timeElapsed }
        self.zenItems.totalTime = TimerVM.timeToString(self.getTotal(values: times))
        self.zenItems.averageTime = TimerVM.timeToString(self.getAverage(values: times))
        
        self.zenItems.totalGames = self.zenGames.count.formatted()
        self.zenItems.averageScore = self.getAverage(values: modeItems.map{ $0.numValidGuesses }).formatted()
    }
    
    // MARK: Calculations
    func getTotal(values: [Int]) -> Int {
        return values.reduce(0, +)
    }
    
    func getAverage(values: [Int]) -> Int {
        guard !values.isEmpty else {return 0}
        return values.reduce(0, +) / values.count
    }
    
    private func getResultCount(modeItems: [GameData], result: GameOverResult) async -> Int {
        var counter = 0
        for item in modeItems {
            if item.gameResult == result.rawValue {
                counter += 1
            }
        }
        return counter
    }
    
    private func getFavMode() -> String {
        
        let standardCount = standardGames.count
        let rushCount: Int = rushGames.count
        let frenzyCount: Int = frenzyGames.count
        let zenCount: Int = zenGames.count
        
        let maxCount = [standardCount, rushCount, frenzyCount, zenCount].max()
        
        switch maxCount {
        case 0: return "----"
        case standardCount: return SystemNames.standard
        case rushCount: return SystemNames.rush
        case frenzyCount: return SystemNames.frenzy
        case zenCount: return SystemNames.zen
        default: return "----"
        }
    }
    
    private func getFavDiff(modeItems: [GameData]) -> String {
        var easy = 0
        var normal = 0
        var hard = 0
        
        for item in modeItems {
            switch item.gameDifficulty {
            case GameDifficulty.easy.rawValue: easy += 1
            case GameDifficulty.normal.rawValue: normal += 1
            case GameDifficulty.hard.rawValue: hard += 1
            default: continue
            }
        }
        
        let maxCount = [easy, normal, hard].max()
        
        switch maxCount {
        case 0: return "----"
        case easy: return GameDifficulty.easy.rawValue.capitalized
        case normal: return GameDifficulty.normal.rawValue.capitalized
        case hard: return GameDifficulty.hard.rawValue.capitalized
        default: return "----"
        }
    }
}
