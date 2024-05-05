import SwiftUI
import SwiftData
import Charts

struct StatsChart: View {
    @ObservedObject var statsVM: StatsVM
    
    var body: some View {
        
        let xaxis = ""
        let yaxis = ""
        
        let data = [ChartData(label: "1", value: statsVM.standardItems.guessMap[1] ?? 0),
                    ChartData(label: "2", value: statsVM.standardItems.guessMap[2] ?? 0),
                    ChartData(label: "3", value: statsVM.standardItems.guessMap[3] ?? 0),
                    ChartData(label: "4", value: statsVM.standardItems.guessMap[4] ?? 0),
                    ChartData(label: "5", value: statsVM.standardItems.guessMap[5] ?? 0),
                    ChartData(label: "6", value: statsVM.standardItems.guessMap[6] ?? 0)]
        
        GroupBox (label: 
                    Label("Guess Distribution", systemImage: SFAssets.stats)
                        .opacity(0.7)
        ) {
            GroupBox {
            Chart {
                ForEach(data) { point in
                    BarMark(x: .value(xaxis, point.value), y: .value(yaxis, point.label))
                }
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading) { _ in
                    AxisValueLabel(horizontalSpacing: 15)
                        .font(.footnote)
                }
            }
            .chartXAxis {
                //AxisMarks(position: .bottom) { _ in }
            }
        }
        }
    }
}

#Preview {
    StatsChart(statsVM: StatsVM())
}
