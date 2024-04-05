//
//  MenuView.swift
//  wordGame
//
//  Created by Wesley Gore on 4/1/24.
//

import SwiftUI

struct MainMenuView: View {
    @State var activeView = ActiveView.tabview
   
    var body: some View {
        VStack{
        switch activeView {
        case ActiveView.empty:
            EmptyView()
        case ActiveView.wordgame:
            WordGameFiveLetters(boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")
        case ActiveView.tabview:
            TabView {
                GameSelectView(startGame: gotoView)
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Game")
                    }
                Text("Friends")
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("Friends")
                    }
                
                Text("Settings")
                    .tabItem() {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Settings")
                    }
                }// end TabView
            }// end switch statement
        }// end Zstack
    }
    
    /// Fades the current main menu out and replaces it with a game having an empty view as a buffer
    func gotoView(view: ActiveView) {
        withAnimation(.linear(duration: 1.0)) {
            activeView = ActiveView.empty
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            withAnimation(.linear(duration: 1.0)) {
                activeView = view
            }
        })
    }
    
}

#Preview {
    MainMenuView()
}
