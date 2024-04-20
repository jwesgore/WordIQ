import SwiftUI

struct GameSelectOptionsView: View {
    @ObservedObject var gameSelectVM: GameSelectVM
    @State var timedMode: Bool = false
    @State var listSelected: String = WordLists.fiveMedium
    //@State var timeSelected: Int
    
    var body: some View {
        VStack {
            
            // MARK: Game Difficulty Buttons
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveEasy)
                listSelected = WordLists.fiveEasy
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: "Easy", modeDescription: "We got rid of all those annoying words with duplicate letters.", isSelected: listSelected == WordLists.fiveEasy)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveMedium)
                listSelected = WordLists.fiveMedium
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: "Normal", modeDescription: "The standard experience, you won't be finding any words in here that feel made up.", isSelected: listSelected == WordLists.fiveMedium)
            })
            .buttonStyle(NoAnimation())
            
            Button(action: {
                gameSelectVM.setList(wordList: WordLists.fiveHard)
                listSelected = WordLists.fiveHard
            }, label: {
                GameSelectOptionsDifficulty(modeTitle: "Hard", modeDescription: "All 15000+ valid words are up for grabs.", isSelected: listSelected == WordLists.fiveHard)
            })
            .buttonStyle(NoAnimation())
            
            // MARK: Game Time Buttons
            if gameSelectVM.activeView == .rushgame || gameSelectVM.activeView == .frenzygame {
                
            }
            
            Spacer()
            
            // MARK: Submit and Back Buttons
            
            VStack {
                Button(action: {
                    gameSelectVM.startGame(gameSelectVM.activeView)
                }, label: {
                    GameSelectOptionsNavButtons(text: "Start Game", backgroundColor: .blue, foregroundColor: .white)
                })
                
                Button(action: {
                    gameSelectVM.gotoModes()
                }, label: {
                    GameSelectOptionsNavButtons(text: "Back", backgroundColor: .clear, foregroundColor: .white)
                })
            }
            .frame(maxWidth: ScreenSize().width! * 0.9)
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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.055)
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
        .frame(width: ScreenSize().width! * 0.9, height: ScreenSize().height! * 0.12)
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
    var times: [Int]
    
    var body: some View {
        HStack {
            Button(action: {
                gameSelectVM.setTime(time: times[0])
            }, label: {
                Text(String(times[0]))
            })
            Button(action: {
                gameSelectVM.setTime(time: times[1])
            }, label: {
                Text(String(times[1]))
            })
            Button(action: {
                gameSelectVM.setTime(time: times[2])
            }, label: {
                Text(String(times[2]))
            })
        }
    }
}

#Preview {
    GameSelectOptionsView(gameSelectVM:GameSelectVM())
}
