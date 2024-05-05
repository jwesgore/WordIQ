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
    }
}

struct StatsItem: View {
    var data: DisplayData
    
    var body: some View {
        
        GroupBox (label:
            Label(data.label, systemImage: data.image ?? "")
                .opacity(0.7)
        ) {
            HStack {
                Spacer()
                
                Text(data.value)
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .kerning(2)
                
                Spacer()
                    .frame(width: 5)
            }
        }
    }
}

#Preview {
    VStack{
        StatsHeader(header: "Test")
        StatsItem(data: DisplayData(label: "Test Label", value: "51"))
    }
}
