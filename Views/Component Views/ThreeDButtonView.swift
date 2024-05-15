import SwiftUI

struct ThreeDButton: View {
    @State private var offset = 0.0
    
    var isPressed: Bool
    var radio: Bool
    let delay: Double
    let speed: Double
    let height: CGFloat
    let width: CGFloat
    let action: () -> Void
    let contents: AnyView
    let backgroundColor: Color
    let radioBackgroundColor: Color
    let borderColor: Color

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
                            .fill(isPressed && radio ? radioBackgroundColor : backgroundColor)
                            .stroke(borderColor, lineWidth: 1)
                            .frame(maxWidth: width, maxHeight: height)
                    )
                    .offset(CGSize(width: 0.0, height: offset))
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    // MARK: Bottom layer
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(borderColor)
                        .stroke(borderColor, lineWidth: 1)
                        .frame(maxWidth: width, maxHeight: height)
                        .offset(CGSize(width: 0.0, height: 5.0))
                        .zIndex(0.0)
                }
            }
        )
        .buttonStyle(NoAnimation())
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                guard !radio else { return }
                withAnimation(.easeInOut(duration: speed)) {
                    self.offset = 5.0
                }
            }
            .onEnded { _ in
                guard !radio else { return }
                withAnimation(.easeInOut(duration: speed)) {
                    self.offset = 0.0
                }
            }
        )
        .onAppear{
            guard radio else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.offset = self.isPressed ? 5.0 : 0.0
            }
        }
        .onChange(of: self.isPressed) {
            guard radio else { return }
            withAnimation(.easeInOut(duration: speed)) {
                self.offset = self.isPressed ? 5.0 : 0.0
            }
        }
        
    }
    
    init(height: CGFloat, width: CGFloat,
         backgroundColor: Color = Color.Buttons.gameModeSelect,
         radioBackgroundColor: Color = Color.Buttons.radioActive,
         borderColor: Color = Color.Border.bcGameModeSelect,
         delay: Double = 0.5,
         speed: Double = 0.1,
         isPressed: Bool = false,
         radio: Bool = false,
         action: @escaping () -> Void,
         contents: AnyView) {
        self.height = height
        self.width = width
        self.backgroundColor = backgroundColor
        self.radioBackgroundColor = radioBackgroundColor
        self.borderColor = borderColor
        
        self.delay = delay
        self.speed = speed
        self.isPressed = isPressed
        self.radio = radio
        
        self.action = action
        self.contents = contents
    }
}

/// Removes animation from button
struct NoAnimation: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

#Preview {
    ThreeDButton(height: 100, width: 200, action: {}, contents: AnyView(Text("Preview").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)))
}
