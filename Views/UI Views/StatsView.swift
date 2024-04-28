import SwiftUI
import SwiftData

struct StatsView: View {
    @Query private var items: [GameData]
    
    var body: some View {
        VStack {
            ForEach(items) { item in
                Text(item.date.formatted())
                Text(String(item.timeElapsed))
                Text(item.gameDifficulty)
                Text(item.gameMode)
            }
        }
    }
}

#Preview {
    StatsView()
}
