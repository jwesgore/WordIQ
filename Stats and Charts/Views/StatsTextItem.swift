import SwiftUI

struct StatsTextItem: View {
    let content: AnyView
    var body: some View {
        GroupBox {
            HStack {
                content
                    .font(.subheadline)
                Spacer()
            }
        }
    }
}
