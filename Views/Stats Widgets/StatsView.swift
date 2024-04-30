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
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.totalGames)
                        StatsItem(value: statsVM.totalTime, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.favoriteMode)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.favoriteDiff)
                    } header: {
                        StatsHeader(header: StatsFilter.overall.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.totalTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.standard.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.totalTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.rush.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.totalTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.averageScore)
                    } header: {
                        StatsHeader(header: StatsFilter.frenzy.rawValue.capitalized)
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Section {
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.totalTime)
                        StatsItem(value: statsVM.totalTime, label: StatsItemLabel.averageTimeElapsed)
                        StatsItem(value: statsVM.totalGames, label: StatsItemLabel.averageScore)
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
