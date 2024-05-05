import SwiftUI
import SwiftData

struct StatsView: View {
    @StateObject var statsVM: StatsVM = StatsVM()
    @Query private var items: [GameData]
    
    var body: some View {
        
        VStack {
            ScrollView {
                // MARK: Overview Stats
                StatsSection(header: AnyView(
                    StatsHeader(header: StatsFilter.overall.rawValue.capitalized)
                ), contents: AnyView(
                    VStack {
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalGames, value: statsVM.overviewItems.totalGames, image: SFAssets.gameController))
         
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalTime, value: statsVM.overviewItems.totalTime, image: SFAssets.timer))
                
                        StatsItem(data: DisplayData(label: StatsItemLabel.favoriteMode, value: statsVM.overviewItems.favMode, image: SFAssets.star))
                  
                        StatsItem(data: DisplayData(label: StatsItemLabel.favoriteDiff, value: statsVM.overviewItems.favDiff, image: SFAssets.star))
                    }
                ))
                
                // MARK: Standard Game Stats
                StatsSection(header: AnyView(
                    StatsHeader(header: StatsFilter.standard.rawValue.capitalized)
                ), contents: AnyView(
                    VStack {
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalGames, value: statsVM.standardItems.totalGames, image: SFAssets.gameController))
                        
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalTime, value: statsVM.standardItems.totalTime, image: SFAssets.timer))
                        
                        StatsItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: statsVM.standardItems.averageTime, image: SFAssets.timer))
                        
                        StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.standardItems.averageScore, image: SFAssets.star))
                        
                        StatsChart(statsVM: statsVM)
                            .frame(minHeight: 250)
                            .frame(maxHeight: 500)
                    }
                ))
                
                // MARK: Rush Game Stats
                StatsSection(header: AnyView(
                    StatsHeader(header: StatsFilter.rush.rawValue.capitalized)
                ), contents: AnyView(
                    VStack {
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalGames, value: statsVM.rushItems.totalGames, image: SFAssets.gameController))

                        StatsItem(data: DisplayData(label: StatsItemLabel.totalTime, value: statsVM.rushItems.totalTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: statsVM.rushItems.averageTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.rushItems.averageScore, image: SFAssets.star))
                    }
                ))
                
                // MARK: Frenzy Game Stats
                StatsSection(header: AnyView(
                    StatsHeader(header: StatsFilter.frenzy.rawValue.capitalized)
                ), contents: AnyView(
                    VStack {
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalGames, value: statsVM.frenzyItems.totalGames, image: SFAssets.gameController))

                        StatsItem(data: DisplayData(label: StatsItemLabel.totalTime, value: statsVM.frenzyItems.totalTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: statsVM.frenzyItems.averageTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.frenzyItems.averageScore, image: SFAssets.star))
                    }
                ))
                
                // MARK: Zen Game Stats
                StatsSection(header: AnyView(
                    StatsHeader(header: StatsFilter.zen.rawValue.capitalized)
                ), contents: AnyView(
                    VStack {
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalGames, value: statsVM.zenItems.totalGames, image: SFAssets.gameController))
                        
                        StatsItem(data: DisplayData(label: StatsItemLabel.totalTime, value: statsVM.zenItems.totalTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: statsVM.zenItems.averageTime, image: SFAssets.timer))

                        StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.zenItems.averageScore, image: SFAssets.star))
                    }
                ))
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
