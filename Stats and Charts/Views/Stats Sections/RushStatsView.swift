import SwiftUI

struct RushStatsView: View {
    let stats: RushStats
    
    var body: some View {
        StatsSection(header: AnyView(
            StatsHeader(header: StatsFilter.rush.rawValue.capitalized)
        ), contents: AnyView(
            VStack {
                StatsValueItem(data: DisplayData(label: StatsItemLabel.totalGames, value: stats.totalGamesPlayed.formatted(), image: SFAssets.gameController))

                StatsValueItem(data: DisplayData(label: StatsItemLabel.totalTime, value: stats.totalTimePlayed.formatted(), image: SFAssets.timer))

                StatsValueItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: stats.averageTimePerMatch.formatted(), image: SFAssets.timer))

                //StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.rushStats.averageScore, image: SFAssets.star))
            }
        ))
    }
}
