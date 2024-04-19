import SwiftUI

struct MainMenuView: View {
    @ObservedObject var transitions = Transitions(activeView: ActiveView.tabview)
    let options: GameModeOptions = GameModeOptions(wordLength: 5, boardSize: 6, wordList: WordLists.fiveMedium)
    let gearSize = ScreenSize().width! * 0.6
    
    var body: some View {
        VStack{
        switch transitions.activeView {
        case .standardgame:
            StandardGameView(endGame: transitions.fadeToWhite, options: options)
        case .rushgame:
            RushGameView(endGame: transitions.fadeToWhite, options: options)
        case .frenzygame:
            FrenzyGameView(endGame: transitions.fadeToWhite, options: options)
        case .zengame:
            ZenGameView(endGame: transitions.fadeToWhite, options: options)
        case .tabview:
            VStack{
                ZStack {
                    HStack{
                        Text(SystemNames.title)
                            .font(.system(size: 20))
                            .kerning(3)
                            .fontWeight(.medium)
                            .frame(width: 200, height: 50.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Spacer()
                        Button(action: {}, label:{
                            Function(value: "gearshape", width: gearSize, height: gearSize, constraint: 25).view
                                .font(.system(size: gearSize > 25 ? 25: gearSize))
                        })
                    }
                    .padding()
                }
            }
            
            TabView {
                GameSelectView(startGame: transitions.fadeToWhite)
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Game")
                    }
                    .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                
                Text("Friends")
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("Friends")
                    }
                    .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                
                Text("Stats")
                    .tabItem() {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Stats")
                    }
                    .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
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
