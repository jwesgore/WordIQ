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
            })
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 8.0))
            Spacer().frame(height:UIScreen.main.bounds.height * 0.05)
        }
    }
}

#Preview {
    GameSelectView(startGame:{_ in})
}
