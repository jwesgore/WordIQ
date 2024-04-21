import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: Game Difficulty Buttons
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveEasy)
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: gameSelectVM.gameOptionsSelect.easy, modeDescription: gameSelectVM.gameOptionsSelect.easyDescription, isSelected: gameSelectVM.options.wordList == WordLists.fiveEasy)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveMedium)
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: gameSelectVM.gameOptionsSelect.medium, modeDescription: gameSelectVM.gameOptionsSelect.mediumDescription, isSelected: gameSelectVM.options.wordList == WordLists.fiveMedium)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveHard)
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
                    GameSelectOptionsNavButtons(text: "Start Game", backgroundColor: .blue, foregroundColor: Color.Text.textColoredBackground)
                })
                
                Button(action: {
                    gameSelectVM.gotoModes()
                }, label: {
                    GameSelectOptionsNavButtons(text: "Back", backgroundColor: .clear, foregroundColor: Color.Text.text)
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
                .fill(isSelected ? Color.LetterBackground.correct :Color.UIElements.gameSelectButton)
                .brightness(0.05)
                .shadow(radius: 5)
        }
        .padding([.top, .bottom], 5)
        
    }
}

private struct GameSelectOptionsTime: View {
    
    var gameSelectVM: GameSelectVM
    var times: [String: Int]
    
    var body: some View {
        HStack {
            ForEach(times.sorted(by: { $0.value < $1.value }), id: \.key) { k, v in
                Button(action:{
                    gameSelectVM.setTime(time: v)
                }, label:{
                    Text(k)
                        .frame(width: ScreenSize.width! * 0.3, height: ScreenSize.height! * 0.1)
                        .frame(maxWidth: 150, maxHeight: 50)
                })
            }
        }
    }
}

#Preview {
    GameSelectOptionsView(gameSelectVM:GameSelectVM())
}
