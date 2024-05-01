import SwiftUI

struct ThreeDButton: View {
    @State var isPressed: Bool = false
    let delay: Double
    
    let height: CGFloat
    let width: CGFloat
    
    let action: () -> Void
    let contents: AnyView
    
    init(height: CGFloat, width: CGFloat, delay: Double = 0.5, action: @escaping () -> Void, contents: AnyView) {
        self.height = height
        self.width = width
        self.delay = delay
        self.action = action
        self.contents = contents
    }

    var body: some View {
        Button(
            action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.action()
                }
            }, label: {
                ZStack {
                    // MARK: Top layer
                    ZStack {
                        contents
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.Buttons.gameModeSelect)
                            .stroke(Color.Border.bcGameModeSelect, lineWidth: 1)
                            .frame(width: width, height: height)
                    )
                    .offset(CGSize(width: 0.0, height: self.isPressed ? 5.0 : 0.0))
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    // MARK: Bottom layer
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.Border.bcGameModeSelect)
                        .stroke(Color.Border.bcGameModeSelect, lineWidth: 1)
                        .frame(width: width, height: height)
                        .offset(CGSize(width: 0.0, height: 5.0))
                        .zIndex(0.0)
                }
            }
        )
        .buttonStyle(NoAnimation())
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.isPressed = true
                }
            }
            .onEnded { _ in
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.isPressed = false
                }
            }
        )
    }
}

#Preview {
    ThreeDButton(height: 100, width: 200, action: {}, contents: AnyView(Text("Preview")))
}
