import SwiftUI

struct MainMenuView: View {
    @ObservedObject var transitions = Transitions(activeView: ActiveView.tabview)
   
    var body: some View {
        VStack{
        switch transitions.activeView {
        case ActiveView.empty:
            EmptyView()
        case ActiveView.wordgame:
            WordGameFiveLetters(endGame: transitions.fadeToWhite, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
        case ActiveView.tabview:
            TabView {
                GameSelectView(startGame: transitions.fadeToWhite)
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Game")
                    }
                Text("Friends")
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("Friends")
                    }
                
                Text("Settings")
                    .tabItem() {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Settings")
                    }
                }// end TabView
            }// end switch statement
        }// end Zstack
    }
}

#Preview {
    MainMenuView()
}
