import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            if self.isActive {
                MainMenuView()
            }
            else {
                VStack {
                    Text(SystemNames.Title.title)
                        .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.title)))
                    Text(SystemNames.Title.caption)
                        .font(.custom(UIFonts.RobotoSlab.bold, size: CGFloat(UIFonts.Size.caption)))
                        .opacity(0.7)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
//            for family in UIFont.familyNames {
//                print("\(family)")
//                for name in UIFont.fontNames(forFamilyName: family) {
//                    print("  \(name)")
//                }
//            }
        }
    }
}

#Preview {
    SplashScreenView()
}
