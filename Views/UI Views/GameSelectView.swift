import SwiftUI

struct GameSelectView: View {
    @ObservedObject var gameSelectVM: GameSelectVM

    var body: some View {
        ZStack {
            GameSelectModeView(gameSelectVM: gameSelectVM)
                .offset(CGSize(width: gameSelectVM.offset, height: 0.0))
            GameSelectOptionsView(gameSelectVM: gameSelectVM)
                .offset(CGSize(width: gameSelectVM.offset + gameSelectVM.offsetAmount, height: 0.0))
        }
    }
}

private struct GameSelectModeView: View {
    var gameSelectVM: GameSelectVM
    var body: some View {
        VStack {
            Button(action: {
                gameSelectVM.gotoOptions(.standardgame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Standard Mode", modeDescription: "The classic game you know and love. Six guesses to get the word.")
            })
            
            Button(action: {
                gameSelectVM.gotoOptions(.rushgame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Rush Mode", modeDescription: "Make as many guesses as you want, but you only have so much time.")
            })
            
            Button(action: {
                gameSelectVM.gotoOptions(.frenzygame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Frenzy Mode", modeDescription: "Only six guesses and a time limit. How many words can you get?")
            })
            
            Button(action: {
                gameSelectVM.gotoOptions(.zengame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Zen Mode", modeDescription: "No time limit, no guess limit. Just play to have fun.")
            })
            
            Spacer()
        }
    }
}

private struct GameMode: View {
    let image: String
    let modeTitle: String
    let modeDescription: String
    
    var body: some View {
  
        GeometryReader { geometry in
        
            HStack (spacing: 0){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: geometry.size.width * 0.2)
                    
                VStack {
                    HStack {
                        Text(modeTitle)
                            .font(.title3)
                        Spacer()
                    }
                    HStack {
                        Text(modeDescription)
                            .font(.caption)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }
                .padding(.leading)
                .frame(width: geometry.size.width * 0.75)
                
            }
            .frame(maxWidth: geometry.size.width , maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

        }
        .foregroundStyle(Color.Text.text)
        .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.12)
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.UIElements.gameSelectButton)
                .brightness(0.05)
                .shadow(radius: 5)
        }
        .padding([.top, .bottom], 5)
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
