import SwiftUI
import SwiftData
import Charts

struct GuessDistributionBarChart: View {
    
    var data: [ChartData]
    
    init(distribution: [Int: Int], range: Int = 6) {
        self.data = [ChartData]()
        
        for i in 1...range {
            self.data.append(ChartData(label: i.formatted(), value: distribution[i] ?? 0))
        }
    }
    
    var body: some View {
        
        let xaxis = ""
        let yaxis = ""
        
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
    GuessDistributionBarChart(distribution: [1:0, 2:2, 3:0, 4:5, 5:2, 6:1])
}
