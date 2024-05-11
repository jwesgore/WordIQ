import SwiftUI
import SwiftData

struct StatsView: View {
    @StateObject var statsVM: StatsVM = StatsVM()
    @Query var standardData: [StandardSaveModel]
    @Query var rushData: [RushSaveModel]
    @Query var frenzyData: [FrenzySaveModel]
    @Query var zenData: [ZenSaveModel]
    
    var body: some View {
        
        VStack {
            ScrollView {
                // MARK: Overview Stats
                OverviewStatsView(stats: statsVM.overviewStats)
                
                // MARK: Standard Game Stats
                StandardStatsView(stats: statsVM.standardStats)
                
                // MARK: Rush Game Stats
                RushStatsView(stats: statsVM.rushStats)
                
                // MARK: Frenzy Game Stats
                FrenzyStatsView(stats: statsVM.frenzyStats)
                
                // MARK: Zen Game Stats
                ZenStatsView(stats: statsVM.zenStats)
            }
        }
        .task {
            self.statsVM.updateStandardStats(models: standardData)
            self.statsVM.updateRushStats(models: rushData)
            self.statsVM.updateFrenzyStats(models: frenzyData)
            self.statsVM.updateZenStats(models: zenData)
            self.statsVM.updateOverviewStats()
        }
        .onChange(of: standardData){
            self.statsVM.updateStandardStats(models: standardData)
            self.statsVM.updateOverviewStats()
        }
        .onChange(of: rushData) {
            self.statsVM.updateRushStats(models: rushData)
            self.statsVM.updateOverviewStats()
        }
        .onChange(of: frenzyData) {
            self.statsVM.updateFrenzyStats(models: frenzyData)
            self.statsVM.updateOverviewStats()
        }
        .onChange(of: zenData) {
            self.statsVM.updateZenStats(models: zenData)
            self.statsVM.updateOverviewStats()
        }
    }
}

#Preview {
    StatsView()
}
