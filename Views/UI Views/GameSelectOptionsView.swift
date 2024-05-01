import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: Game Difficulty Buttons
            
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.easy, list: gameSelectVM.options.wordList) {
                    gameSelectVM.setDifficulty(wordList: WordLists.fiveEasy, difficulty: .easy)
                }
            
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.medium, list: gameSelectVM.options.wordList) {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveMedium, difficulty: .normal)
            }
            
            GameSelectOptionsDifficulty(diffParams: gameSelectVM.gameOptionsSelect.hard, list: gameSelectVM.options.wordList) {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveHard, difficulty: .hard)
            }
            
            // MARK: Game Time Buttons
            if gameSelectVM.activeView == .rushgame {
                GameSelectOptionsTime(gameSelectVM: gameSelectVM, times: gameSelectVM.gameOptionsSelect.rushModeTimes)
            } else if gameSelectVM.activeView == .frenzygame {
                GameSelectOptionsTime(gameSelectVM: gameSelectVM, times: gameSelectVM.gameOptionsSelect.frenzyModeTimes)
            }
            
            Spacer()
            
            // MARK: Submit and Back Buttons
            VStack {
                Button(action: {
                    gameSelectVM.startGame(gameSelectVM.activeView)
                }, label: {
                    GameSelectOptionsNavButtons(text: SystemNames.startGame, backgroundColor: .blue, foregroundColor: Color.Text.textColoredBackground)
                })
                
                Button(action: {
                    gameSelectVM.gotoModes()
                }, label: {
                    GameSelectOptionsNavButtons(text: SystemNames.back, backgroundColor: .clear, foregroundColor: Color.Text.text)
                })
            }
            .frame(maxWidth: ScreenSize.width! * 0.9)
            .padding(.bottom)
           
        }
    }
}

private struct GameSelectOptionsNavButtons: View {
    var text: String
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        Text(text)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize.height! * 0.055)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 25.0))
            .foregroundStyle(foregroundColor)
    }
}

private struct GameSelectOptionsDifficulty: View{
    
    let diffParams: DifficultyParams
    let list: String
    let action: () -> Void
    
    let height: CGFloat = ScreenSize.height! * 0.12
    let width: CGFloat = ScreenSize.width! * 0.9
    let delay: Double = 0.2
    
    var body: some View {
        
        ThreeDButton(height: height, width: width, delay: delay, isPressed: list == diffParams.list, radio: true, action: action, contents: AnyView(
            ZStack {
                // MARK: Title
                VStack {
                    Spacer()
                        .frame(height: 20)
                    
                    HStack{
                        Spacer()
                            .frame(width: 20)
                        
                        Text(diffParams.label)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Text.text)
                            .opacity(0.8)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: width, height: height)
                
                // MARK: Body
                VStack {
                    Spacer()
                        .frame(height: 5 + height / 2)
                    
                    HStack{
                        Text(diffParams.description)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Text.text)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .opacity(0.5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .frame(width: width, height: height)
            }
        ))
    }
}

private struct GameSelectOptionsTime: View {
    
    @ObservedObject var gameSelectVM: GameSelectVM
    var times: [String: Int]
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                HStack (spacing: 8) {
                    ForEach(times.sorted(by: { $0.value < $1.value }), id: \.key) { k, v in
                        Button(action:{
                            gameSelectVM.setTime(time: v)
                        }, label:{
                            Text(k)
                                .frame(maxWidth: geometry.size.width * 0.33, maxHeight: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .fill(gameSelectVM.options.timeLimit == v ? Color.LetterBackground.correct : Color.UIElements.gameSelectButton)
                                        .stroke(Color.Border.bcInactive, lineWidth: 1)
                                )
                                .foregroundStyle(Color.Text.text)
                        })
                        .buttonStyle(NoAnimation())
                    }
                }
            }
            .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.07)
        }
        
    }
}

#Preview {
    GameSelectOptionsView(gameSelectVM: GameSelectVM())
}
