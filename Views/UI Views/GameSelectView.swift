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
                GameMode(image: SFAssets.gameController, modeTitle: SystemNames.standardMode, modeDescription: Descriptions.standardMode)
            })
            
            Button(action: {
                gameSelectVM.options.timeLimit = 60
                gameSelectVM.gotoOptions(.rushgame)
            }, label: {
                GameMode(image: SFAssets.gameController, modeTitle: SystemNames.rushMode, modeDescription: Descriptions.rushMode)
            })
            
            Button(action: {
                gameSelectVM.options.timeLimit = 90
                gameSelectVM.gotoOptions(.frenzygame)
            }, label: {
                GameMode(image: SFAssets.gameController, modeTitle: SystemNames.frenzyMode, modeDescription: Descriptions.frenzyMode)
            })
            
            Button(action: {
                gameSelectVM.gotoOptions(.zengame)
            }, label: {
                GameMode(image: SFAssets.gameController, modeTitle: SystemNames.zenMode, modeDescription: Descriptions.zenMode)
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
        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.UIElements.gameSelectButton)
                .stroke(Color.Border.bcInactive, lineWidth: 1)
                
        }
        .padding([.top, .bottom], 5)
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
