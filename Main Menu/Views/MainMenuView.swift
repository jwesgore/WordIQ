import SwiftUI

struct MainMenuView: View {
    @ObservedObject var mainMenuVM: MainMenuVM = MainMenuVM()
    
    var body: some View {
        VStack{
        switch mainMenuVM.activeView {
        case .standardgame, .rushgame, .frenzygame, .zengame :
            GameModeView(endGame: mainMenuVM.fadeToWhite, options: mainMenuVM.options)
        case .tabview:
            MainMenuTopBar()
            MainMenuBody(mainMenuVM: mainMenuVM)
        default:
            EmptyView()
        }// end switch statement
        }// end Zstack
    }
}

private struct MainMenuBody: View {
    
    @ObservedObject var mainMenuVM: MainMenuVM
    
    var body: some View {
        TabView {
            GameSelectView(gameSelectVM: mainMenuVM.gameSelectVM)
                .tabItem() {
                    Image(systemName: SFAssets.home)
                    Text(SystemNames.game)
                }
                .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            
            Text("Friends")
                .tabItem() {
                    Image(systemName: SFAssets.friends)
                    Text(SystemNames.friends)
                }
                .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            
            StatsView()
                .tabItem() {
                    Image(systemName: SFAssets.stats)
                    Text(SystemNames.stats)
                }
                .toolbarBackground(Color.UIElements.tabView, for:.tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }// end TabView
    }
}

private struct MainMenuTopBar: View {
    let gearSize = 50.0
    var body: some View {
        VStack{
            ZStack {
                HStack{
                    Text(SystemNames.Title.title)
                        .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title2)))

                    Spacer()
                    Button(action: {}, label:{
                        Function(value: SFAssets.settings, width: gearSize, height: gearSize, constraint: 25).view
                            .font(.system(size: gearSize > 25 ? 25: gearSize))
                    })
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct WordlTitle: View {
    var body: some View{
        ZStack {
            
        }
    }
}

#Preview {
    MainMenuView()
}
