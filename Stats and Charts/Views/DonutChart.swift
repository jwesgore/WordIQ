import SwiftUI
import Charts

struct DonutChart: View {
    
    var data: [ChartData]
    var legend: Bool
    
    init(distribution: [String: Int], legend: Bool = true) {
        self.legend = legend
        self.data = [ChartData]()
        
        for item in distribution {
            self.data.append(ChartData(label: item.key, value: item.value))
        }
    }
    
    var body: some View {
        Chart {
            ForEach(data) { point in
                SectorMark(angle: .value(point.label, point.value), innerRadius: .ratio(0.6))
                    .foregroundStyle(by: .value("Name", point.label))
            }
        }
        .chartLegend(legend ? .visible : .hidden)
    }
}
