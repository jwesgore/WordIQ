import SwiftUI
import SwiftData

struct StatsView: View {
    @Query private var items: [GameData]
    @StateObject var statsVM: StatsVM = StatsVM()
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack {
                    Section {
                        StatsItem(value: statsVM.overviewItems.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.overviewItems.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.overviewItems.favMode, label: StatsItemLabel.favoriteMode)
                        StatsItem(value: statsVM.overviewItems.favDiff, label: StatsItemLabel.favoriteDiff)
                    } header: {
                        StatsHeader(header: StatsFilter.overall.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.standardItems.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.standardItems.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.standardItems.averageTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.standardItems.averageScore, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.standard.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.rushItems.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.rushItems.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.rushItems.averageTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.rushItems.averageScore, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.rush.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.frenzyItems.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.frenzyItems.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.frenzyItems.averageTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.frenzyItems.averageScore, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.frenzy.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.zenItems.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.zenItems.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.zenItems.averageTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.zenItems.averageScore, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.zen.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear{
            statsVM.items = items
            statsVM.loadValues()
        }
        .onChange(of: items) {
            statsVM.items = items
            statsVM.loadValues()
        }
    }
}

#Preview {
    StatsView()
}
