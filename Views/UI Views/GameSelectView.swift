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
    @State var isPressed: Bool = false
    
    let image: String
    let modeTitle: String
    let modeDescription: String
    let action: () -> Void
    
    var body: some View {
        Button(
            action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.action()
                }
            }, label: {
                ZStack {
                    // MARK: Top layer
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
                        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)
                        
                        // MARK: Body
                        VStack {
                            Spacer()
                                .frame(height: 5 + ScreenSize.height! * 0.06)
                            
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
                        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)

                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.Buttons.gameModeSelect)
                            .stroke(Color.Border.bcGameModeSelect, lineWidth: 1)
                            .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)
                    )
                    .offset(CGSize(width: 0.0, height: self.isPressed ? 5.0 : 0.0))
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.Border.bcGameModeSelect)
                        .stroke(Color.Border.bcGameModeSelect, lineWidth: 1)
                        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)
                        .offset(CGSize(width: 0.0, height: 5.0))
                        .zIndex(0.0)
                }
            }
        )
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.isPressed = true
                }
            }
            .onEnded { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.isPressed = false
                }
            }
        )
    }
}

#Preview {
    GameSelectView(gameSelectVM:GameSelectVM())
}
