//
//  StandardStatsView.swift
//  wordGame
//
//  Created by Wesley Gore on 5/10/24.
//

import SwiftUI

struct StandardStatsView: View {
    let stats: StandardStats
    
    var body: some View {
        StatsSection(header: AnyView(
            StatsHeader(header: StatsFilter.standard.rawValue.capitalized)
        ), contents: AnyView(
            VStack {
                StatsValueItem(data: DisplayData(label: StatsItemLabel.totalGames, value: stats.totalGamesPlayed.formatted(), image: SFAssets.gameController))
                
                StatsValueItem(data: DisplayData(label: StatsItemLabel.totalTime, value: stats.totalTimePlayed.formatted(), image: SFAssets.timer))
                
                StatsValueItem(data: DisplayData(label: StatsItemLabel.averageTimeElapsed, value: stats.averageTimePerMatch.formatted(), image: SFAssets.timer))
                
                //StatsItem(data: DisplayData(label: StatsItemLabel.averageScore, value: statsVM.standardStats.avera, image: SFAssets.star))
                
                GuessDistributionBarChart(distribution: stats.guessDistribution)
                    .frame(minHeight: 250)
                    .frame(maxHeight: 500)
            }
        ))
    }
}
