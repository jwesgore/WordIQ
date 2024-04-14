import SwiftUI

struct TimerView: View {
    
    @State var totalTime: Int
    @State var running: Bool = false
    
    let timer = Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common)
        
    var body: some View {
        ZStack {
            
        }
    }
}

#Preview {
    TimerView(totalTime: 60)
}
