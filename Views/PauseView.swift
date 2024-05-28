import SwiftUI

struct PauseMenuView: View {
    
    var model: PauseVM
    
    var body: some View {
        ZStack {
            VStack {
                Text("Game Paused")
                    .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title)))
                Spacer()
                GroupBox {
                    PauseMenuElement (
                        label: "Time Elapsed",
                        value: "Temp"
                    )
                    Divider()
                    PauseMenuElement (
                        label: "XP Earned",
                        value: "Temp"
                    )
                    Divider()
                    PauseMenuElement (
                        label: "Guess #",
                        value: "Temp"
                    )
                }
                Spacer()
                HStack {
                    Text("* Ending a game will not be counted as a loss")
                        .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.subheading)))
                        .foregroundStyle(.opacity(0.7))
                    Spacer()
                }
                
                ThreeDButton(height: 50.0,
                             width: 500.0,
                             action: {model.quitGame()},
                             contents: AnyView(
                                Text("End Game")
                                    .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
                             ))
                .padding(.bottom)
                
                ThreeDButton(height: 50.0,
                             width: 500.0,
                             action: {model.back()},
                             contents: AnyView(
                                Text("Cancel")
                                    .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
                             ))
            }
            .padding()
        }
    }
    
}

private struct PauseMenuElement: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        .font(.custom(UIFonts.RobotoSlab.regular, size: CGFloat(UIFonts.Size.title3)))
    }
}

#Preview {
    PauseMenuView(model: PauseVM())
}
