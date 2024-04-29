import SwiftUI
import SwiftData

struct StatsView: View {
    @Query private var items: [GameData]
    
    var body: some View {
        VStack {
            ForEach(items) { item in
                Text(item.date.formatted())
                Text(String(item.timeElapsed))
                Text("Game Difficulty" + item.gameDifficulty)
                Text("Game Mode" + item.gameMode)
                Text("Game Result" + item.gameResult)
                Text("Invalid guesses:" + String(item.numInvalidGuesses))
                Text("Valid guesses:" + String(item.numValidGuesses))
            }
        }
    }
}

#Preview {
    StatsView()
}
