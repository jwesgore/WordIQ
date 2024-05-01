import SwiftUI

struct ThreeDButton: View {
    var isPressed: Bool
    @State private var offset = 0.0
    
    var radio: Bool
    
    let delay: Double
    
    let height: CGFloat
    let width: CGFloat
    
    let action: () -> Void
    let contents: AnyView
    
    init(height: CGFloat, width: CGFloat, delay: Double = 0.5, isPressed: Bool = false, radio: Bool = false, action: @escaping () -> Void, contents: AnyView) {
        self.height = height
        self.width = width
        self.delay = delay
        self.isPressed = isPressed
        self.radio = radio
        
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
                    .offset(CGSize(width: 0.0, height: offset))
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
                guard !radio else { return }
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.offset = 5.0
                }
            }
            .onEnded { _ in
                guard !radio else { return }
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.offset = 0.0
                }
            }
        )
        .onAppear{
            guard radio else { return }
            self.offset = self.isPressed ? 5.0 : 0.0
        }
        .onChange(of: self.isPressed) {
            guard radio else { return }
            withAnimation(.easeInOut(duration: 0.1)) {
                self.offset = self.isPressed ? 5.0 : 0.0
            }
        }
        
    }
}

/// Removes animation from button
struct NoAnimation: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

#Preview {
    ThreeDButton(height: 100, width: 200, action: {}, contents: AnyView(Text("Preview")))
}
