import SwiftUI

struct WidgetView: View {
    let value = "01:30"
    let label = "Avg. Time"
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Text(value)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .kerning(2)
                }
                .frame(height: geo.size.height * 0.5)
                
                Text(label)
                    .fontWeight(.bold)
                    .font(.headline)
                    .opacity(0.7)
                    .frame(height: geo.size.height * 0.1)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(maxWidth: ScreenSize.width! * 0.4, maxHeight: ScreenSize.height! * 0.1)
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.gray.opacity(0.5))
        )
    }
}

#Preview {
    WidgetView()
}
