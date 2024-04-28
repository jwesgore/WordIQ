import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: Game Difficulty Buttons
            Button(action: {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveEasy, difficulty: .easy)
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: gameSelectVM.gameOptionsSelect.easy, modeDescription: gameSelectVM.gameOptionsSelect.easyDescription, isSelected: gameSelectVM.options.wordList == WordLists.fiveEasy)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveMedium, difficulty: .normal)
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: gameSelectVM.gameOptionsSelect.medium, modeDescription: gameSelectVM.gameOptionsSelect.mediumDescription, isSelected: gameSelectVM.options.wordList == WordLists.fiveMedium)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setDifficulty(wordList: WordLists.fiveHard, difficulty: .hard)
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: gameSelectVM.gameOptionsSelect.hard, modeDescription: gameSelectVM.gameOptionsSelect.hardDescription, isSelected: gameSelectVM.options.wordList == WordLists.fiveHard)
            })
            .buttonStyle(NoAnimation())
            
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

/// Removes animation from button
private struct NoAnimation: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
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
    
    let modeTitle: String
    let modeDescription: String
    let isSelected: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing: 0){
                VStack(spacing:8) {
                    HStack {
                        Text(modeTitle)
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    HStack {
                        Text(modeDescription)
                            .font(.caption)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }
                .padding(.leading)
                .frame(width: geometry.size.width)
                
            }
            .frame(maxWidth: geometry.size.width , maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        .foregroundStyle(Color.Text.text)
        .frame(width: ScreenSize.width! * 0.9, height: ScreenSize.height! * 0.12)
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(isSelected ? Color.LetterBackground.correct : Color.UIElements.gameSelectButton)
                .stroke(Color.Border.bcInactive, lineWidth: 1)
        }
        .padding([.top, .bottom], 5)
        
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
