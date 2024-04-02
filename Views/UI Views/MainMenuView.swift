//
//  MenuView.swift
//  wordGame
//
//  Created by Wesley Gore on 4/1/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink (destination: WordGameFiveLetters(boardSize: 6, wordLength: 5, wordsFile: "five_letter_words_medium")) {
                    Text("Word Game")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }
                .frame(width: 200, height: 50.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.gray, lineWidth: 1.0)
                )
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MainMenuView()
}
