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
        ScrollView {
            VStack (spacing: 20) {
                
                GameSelectInfoBox()
                
                GameModeButtonView(image: SFAssets.gameController, modeTitle: SystemNames.standardMode) {
                    gameSelectVM.gotoOptions(.standardgame)
                } quickplay: {
                    gameSelectVM.quickplay(.standardgame)
                }
                
                GameModeButtonView(image: SFAssets.gameController, modeTitle: SystemNames.rushMode) {
                    gameSelectVM.options.timeLimit = 60
                    gameSelectVM.gotoOptions(.rushgame)
                } quickplay: {
                    gameSelectVM.quickplay(.rushgame)
                }
                
                GameModeButtonView(image: SFAssets.gameController, modeTitle: SystemNames.frenzyMode) {
                    gameSelectVM.options.timeLimit = 90
                    gameSelectVM.gotoOptions(.frenzygame)
                } quickplay: {
                    gameSelectVM.quickplay(.frenzygame)
                }
                
                GameModeButtonView(image: SFAssets.gameController, modeTitle: SystemNames.zenMode) {
                    gameSelectVM.gotoOptions(.zengame)
                } quickplay: {
                    gameSelectVM.quickplay(.zengame)
                }
                
                Spacer()
            }
            .frame(maxWidth: UISize.main.maxWidth)
            .padding(.horizontal, UISize.main.sectionSidePadding)
        }
    }
}

private struct GameSelectInfoBox: View {
    
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Message board placeholder")
                        .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title)))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 10)
                HStack {
                    Spacer()
                    VStack {
                        Text("1234")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
                        Text("Placeholder")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.subheading)))
                    }
                    Spacer()
                    VStack {
                        Text("1234")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
                        Text("Placeholder")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.subheading)))
                    }
                    Spacer()
                    VStack {
                        Text("1234")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
                        Text("Placeholder")
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.subheading)))
                    }
                    Spacer()
                }
            }
        }
    }
}

private struct GameModeButtonView: View {
    let image: String
    let modeTitle: String
    let action: () -> Void
    let quickplay: () -> Void
    
    let height: CGFloat = ScreenSize.height! * 0.06
    let modeWidth: CGFloat = ScreenSize.width!
    let delay: Double = 0.2
    
    var body: some View {
        HStack {
            // MARK: Mode Select
            ThreeDButton(height: height, 
                         width: UISize.main.maxWidth,
                         delay: delay, speed: 0.025,
                         action: action,
                         contents:
            AnyView(
                ZStack {
                    // MARK: Title
                    VStack {
                        Spacer()
                        
                        HStack{
                            Spacer()
                                .frame(width: 20)
                            
                            Text(modeTitle)
                                .font(.custom(UIFonts.RobotoSlab.semiBold, size: CGFloat(UIFonts.Size.title2)))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.Text.text)
                                .opacity(0.8)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            ))
            .padding(.trailing, 5)
            
            // MARK: Quickplay
            ThreeDButton(height: height, width: height, delay: delay, speed: 0.1, action: quickplay, contents: AnyView(
                ZStack {
                    // MARK: Title
                    VStack {
                        HStack{
                            Image(systemName: SFAssets.playCircle)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.Text.text)
                                .opacity(0.8)
                        }
                    }
                    .frame(width: height, height: height)
                }
            ))
        }
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
