import SwiftUI

struct MainMenuView: View {
    @ObservedObject var transitions = Transitions(activeView: ActiveView.tabview)
    let gearSize = ScreenSize().width! * 0.6
    
    var body: some View {
        VStack{
        switch transitions.activeView {
        case ActiveView.wordgame:
            WordGameFiveLetters(endGame: transitions.fadeToWhite, boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
        case ActiveView.tabview:
            VStack{
                HStack{
                    Spacer()
                    Button(action: {}, label:{
                        Function(value: "gearshape", width: gearSize, height: gearSize, constraint: 25).view
                            .font(.system(size: gearSize > 25 ? 25: gearSize))
                            
                    })
                    
                }
                .padding()
            }
            
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
                
                Text("Stats")
                    .tabItem() {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Stats")
                    }
                }// end TabView
        default:
            EmptyView()
        }// end switch statement
        }// end Zstack
    }
}

#Preview {
    MainMenuView()
}
