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
        VStack (spacing: 15) {
            
            GameModeView(image: SFAssets.gameController, modeTitle: SystemNames.standardMode, modeDescription: Descriptions.standardMode) {
                gameSelectVM.gotoOptions(.standardgame)
            }
 
            GameModeView(image: SFAssets.gameController, modeTitle: SystemNames.rushMode, modeDescription: Descriptions.rushMode) {
                gameSelectVM.options.timeLimit = 60
                gameSelectVM.gotoOptions(.rushgame)
            }
            
            GameModeView(image: SFAssets.gameController, modeTitle: SystemNames.frenzyMode, modeDescription: Descriptions.frenzyMode) {
                gameSelectVM.options.timeLimit = 90
                gameSelectVM.gotoOptions(.frenzygame)
            }
            
            GameModeView(image: SFAssets.gameController, modeTitle: SystemNames.zenMode, modeDescription: Descriptions.zenMode) {
                gameSelectVM.gotoOptions(.zengame)
            }
            
            Spacer()
        }
        
    }
}

private struct GameModeView: View {
    let image: String
    let modeTitle: String
    let modeDescription: String
    let action: () -> Void
    
    let height: CGFloat = ScreenSize.height! * 0.12
    let width: CGFloat = ScreenSize.width! * 0.9
    let delay: Double = 0.2
    
    var body: some View {
        ThreeDButton(height: height, width: width, delay: delay, speed: 0.25, action: action, contents: AnyView(
            ZStack {
                // MARK: Title
                VStack {
                    Spacer()
                        .frame(height: 20)
                    
                    HStack{
                        Spacer()
                            .frame(width: 20)
                        
                        Text(modeTitle)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Text.text)
                            .opacity(0.8)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: width, height: height)
                
                // MARK: Body
                VStack {
                    Spacer()
                        .frame(height: 5 + height / 2)
                    
                    HStack{
                        Text(modeDescription)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Text.text)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .opacity(0.5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .frame(width: width, height: height)
            }
        ))
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
