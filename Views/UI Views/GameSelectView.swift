import SwiftUI

struct GameSelectView: View {
    var startGame: (ActiveView) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Button( action: {
                startGame(ActiveView.wordgame)
            }, label: {
                Text("Play Game")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.05)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 8.0))
            })
            Spacer().frame(height:ScreenSize().height! * 0.05)
        }
    }
}

#Preview {
    GameSelectView(startGame:{_ in})
}
