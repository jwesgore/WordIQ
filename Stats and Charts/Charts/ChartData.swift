/// Used for more easily packaging data to show on a chart
struct ChartData: Identifiable, Equatable {
    var id: String {label}
    
    var label: String
    var value: Int
    
    var image: String?
}
