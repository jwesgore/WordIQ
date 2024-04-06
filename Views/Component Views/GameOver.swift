import SwiftUI

struct GameOver: View {
    
    @ObservedObject var model: GameOverVM
    let mainmenu: (ActiveView) -> Void
    let nextView: (ActiveView) -> Void
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
       
        ZStack {
            VStack{
                Button( action: {
                    //nextView(ActiveView.wordgame)
                    model.playAgain()
                }, label: {
                    Text("Play Again")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.05)
                        .background(.blue)
                        .foregroundStyle(Color("TextColor"))
                        .clipShape(.rect(cornerRadius: 16.0))
                })
                
                Button( action: {
                    mainmenu(ActiveView.tabview)
                }, label: {
                    Text("Main Menu")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.05)
                        .foregroundStyle(Color("TextColor"))
                })
            }
            .frame(width:ScreenSize().width! * 0.9)
        }
    }
}

#Preview {
    GameOver(model:GameOverVM(), mainmenu: {_ in }, nextView: {_ in })
}
