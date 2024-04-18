import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerVM: TimerVM
        
    var body: some View {
        Text(timerVM.currentTimeFormatted)
    }
}

#Preview {
    TimerView(timerVM:TimerVM(60))
}
