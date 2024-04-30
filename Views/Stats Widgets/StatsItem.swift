import SwiftUI

struct StatsHeader: View {
    var header: String
    
    var body: some View {
        
        HStack {
            Text(header)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: ScreenSize.width! * 0.9, maxHeight: ScreenSize.height! * 0.1)
        .frame(minHeight: ScreenSize.height! * 0.05)
    }
}

struct StatsItem: View {
    var value: String
    var label: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Spacer()
                    
                    Text(value)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .kerning(2)
                    
                    Spacer()
                        .frame(width: geo.size.width * 0.05)
                }
                .frame(height: geo.size.height * 0.5)
                
                HStack {
                    Spacer()
                        .frame(width: geo.size.width * 0.05)
                    
                    Text(label)
                        .fontWeight(.bold)
                        .font(.headline)
                        .opacity(0.7)
                        .frame(maxHeight: geo.size.height * 0.1)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(maxWidth: ScreenSize.width! * 0.9, maxHeight: ScreenSize.height! * 0.1)
        .frame(minHeight: ScreenSize.height! * 0.05)
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.gray.opacity(0.5))
        )
    }
}

#Preview {
    VStack{
        StatsHeader(header: "Test")
        StatsItem(value: "1:30", label: "Avg. Time")
    }
}
