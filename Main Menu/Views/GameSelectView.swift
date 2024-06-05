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
     
        VStack (spacing: 10) {
            
            // GameSelectInfoBox()
            Spacer()
            
            HStack {
                GameModeButtonView(mode: .daily) {
                    gameSelectVM.gotoOptions(.standardgame)
                }
                .aspectRatio(3.0, contentMode: .fit)
                
                GameModeButtonView(mode: .quickplay) {
                    gameSelectVM.options.timeLimit = 60
                    gameSelectVM.gotoOptions(.rushgame)
                }
                .aspectRatio(3.0, contentMode: .fit)
            }
            
   
                GameModeButtonView(mode: .standardgame) {
                    gameSelectVM.gotoOptions(.standardgame)
                }
                .aspectRatio(5.0, contentMode: .fit)
                
                GameModeButtonView(mode: .rushgame) {
                    gameSelectVM.options.timeLimit = 60
                    gameSelectVM.gotoOptions(.rushgame)
                }
                .aspectRatio(5.0, contentMode: .fit)
            

                GameModeButtonView(mode: .frenzygame) {
                    gameSelectVM.options.timeLimit = 90
                    gameSelectVM.gotoOptions(.frenzygame)
                }
                .aspectRatio(5.0, contentMode: .fit)
                
                GameModeButtonView(mode: .zengame) {
                    gameSelectVM.gotoOptions(.zengame)
                }
                .aspectRatio(5.0, contentMode: .fit)
            
            
            Spacer()
        }
        .frame(maxWidth: UISize.main.maxWidth)
        .padding(.horizontal, UISize.main.sectionSidePadding)
        
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
    let mode: GameMode
    let action: () -> Void
    
    let height: CGFloat = 200
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
                        Text(mode.value)
                            .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title2)))
                            .foregroundStyle(Color.Text.text)
                        
                        Text(mode.caption)
                            .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.caption)))
                            .foregroundStyle(Color.Text.text)
                            .opacity(0.6)
                    }
                }
            ))
        }
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
