import SwiftUI

struct GameSelectView: View {
    var startGame: (ActiveView) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                startGame(.standardgame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Standard Mode", modeDescription: "The classic game you know and love. Six guesses to get the word.")
            })
            
            Button(action: {
                startGame(.rushgame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Rush Mode", modeDescription: "description text")
            })
            
            Button(action: {
                startGame(.frenzygame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Frenzy Mode", modeDescription: "description text")
            })
            
            Button(action: {
                startGame(.zengame)
            }, label: {
                GameMode(image: "gamecontroller", modeTitle: "Zen Mode", modeDescription: "description text")
            })
            
            Spacer().frame(height:ScreenSize().height! * 0.05)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color("Standard"))
    }
}

struct GameMode: View {
    let image: String
    let modeTitle: String
    let modeDescription: String
    
    var body: some View {
  
        GeometryReader { geometry in
            

            HStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.15)
                    .padding()
                VStack {
                    HStack {
                        Text(modeTitle)
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Text(modeDescription)
                            .font(.caption)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }
                .padding()
            }
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

        }
        .foregroundStyle(Color.Text.text)
        .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.12)
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.standard)
                .brightness(0.075)
                .shadow(color: Color.Text.text.opacity(0.3), radius: 5)
        }
        .padding([.top, .bottom], 5)
        
    }
}

#Preview {
    GameSelectView(startGame:{_ in})
}
