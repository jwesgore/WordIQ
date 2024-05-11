import SwiftUI

struct OverviewStatsView: View {
    
    let stats: OverviewStats
    
    var body: some View {
        StatsSection(header: AnyView(
            StatsHeader(header: StatsFilter.overall.rawValue.capitalized)
        ), contents: AnyView(
            VStack {
                
                StatsTextItem(content: AnyView(
                    HStack {
                        Text("You have spent a total of ") +
                        Text(TimerVM.timeToLongString(stats.totalTimePlayed))
                            .fontWeight(.semibold) +
                        Text(" playing ") +
                        Text(stats.totalGamesPlayed.formatted())
                            .fontWeight(.semibold) +
                        Text(" games.")
                    }))

                GroupBox {
                    HStack {
                        VStack {
                            Text("Your favorite mode is ") +
                            Text(stats.favMode.0.value)
                                .fontWeight(.semibold) +
                            Text(" at ") +
                            Text(String(Int(stats.favMode.1 * 100.0)) + "%")
                                .fontWeight(.semibold) +
                            Text(" of your total games played!")
                            Spacer()
                        }
                        .font(.subheadline)
                        
                        Spacer()
                        DonutChart(distribution: stats.modeDistribution, legend: false)
                    }
                }
                .frame(maxHeight: .infinity)
                
            }
        ))
    }
}
