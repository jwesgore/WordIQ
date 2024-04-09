import SwiftUI

struct GameSelectView: View {
    var startGame: (ActiveView) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Button( action: {
                startGame(ActiveView.wordgame)
            }, label: {
                Text("Standard Game")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.05)
                    .background(.blue)
                    .foregroundStyle(Color("TextColoredBackground"))
                    .clipShape(.rect(cornerRadius: 25.0))
            })
            Button( action: {
                startGame(ActiveView.wordgame)
            }, label: {
                Text("Rush Game")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.05)
                    .background(.blue)
                    .foregroundStyle(Color("TextColoredBackground"))
                    .clipShape(.rect(cornerRadius: 25.0))
            })
            Button( action: {
                startGame(ActiveView.wordgame)
            }, label: {
                Text("Frenzy Game")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.05)
                    .background(.blue)
                    .foregroundStyle(Color("TextColoredBackground"))
                    .clipShape(.rect(cornerRadius: 25.0))
            })

            Button( action: {
                startGame(ActiveView.wordgame)
            }, label: {
                Text("Zen Game")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.05)
                    .background(.blue)
                    .foregroundStyle(Color("TextColoredBackground"))
                    .clipShape(.rect(cornerRadius: 25.0))
            })
            Spacer().frame(height:ScreenSize().height! * 0.05)
        }
    }
}

#Preview {
    GameSelectView(startGame:{_ in})
}
