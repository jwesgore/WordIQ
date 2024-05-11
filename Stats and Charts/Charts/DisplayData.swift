/// Used for more easily packaging data to display on the stats page
struct DisplayData: Identifiable, Equatable {
    var id: String {label}
    
    var label: String
    var value: String
    
    var image: String?
}
